From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: [PATCH] serial-u16550 driver.  Fixes buffer blocking
 bug
Date: Mon, 03 Nov 2003 17:44:21 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FA70475.9000008@pianodisc.com>
References: <3FA03585.1000901@pianodisc.com>	<s5hn0biyj9z.wl@alsa2.suse.de>	<3FA183B1.3090706@pianodisc.com> <s5hn0bhuwjg.wl@alsa2.suse.de>
Reply-To: derosier@pianodisc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0bhuwjg.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 30 Oct 2003 13:33:37 -0800,
> Steve deRosier wrote:
> 
>>Takashi,
>>
>>Thanks for your response.  I've addressed your issues below.  Let's 
>>discuss this and if necessary I'll modify my fix.
>>
>>
>>>>1. Move all checks of buffer overflow and such to the 
>>>>actual buffer write and read routines.  This makes
>>>>the buffer routines more robust and encaspulates buffer
>>>>opperations better.
>>>
>>>
>>>the check in the caller may be still needed for the multi-bytes write
>>>(e.g. for switching the port).  otherwise, the port-switch command
>>>can be mixed and messed up when the device is accessed concurrently.
>>>
>>
>>I thought about this, but decided it's not a large issue since it is 
>>mitigated by the natural operation of the driver.
>>For normal opperation:  As this is called with interupts off, the 
>>process can't be interupted.  The function doesn't return until after 
>>we've drained the snd_rawmidi_transmit(), and if we do decide to insert 
>>a "f5..." msg, we do the whole msg before we can return.  So, no issue 
>>durring normal opperation.  So concurrent access doesn't apear to be a 
>>large issue.
> 
>  
> yes, normally it's ok.  the problem would be only the full-buffer
> state.
> 

Ok, as you don't seem swayed by my argument, I'll go ahead and put a 
check in that will address the issue, but not break other things.

>>>>2. Always try to send data to the buffers.  Don't interupt
>>>>normal opperation of the algoritim because buffers are full.
>>>>This was what was actually causing the data to be left in 
>>>>rawmidi and thus causing it to lock up.  This is helped
>>>>by moving the buffer size checks into the routines.
>>>
>>>
>>>this is the questionary behavior.
>>>the fact that the local buffer is full means that the transfer doesn't
>>>work.  so, it is quite correct behavior that rawmidi blocks the
>>>further write (in blocking mode), i think.  and, it should return
>>>-EAGAIN in non-blocking mode.
>>>or, at least, we can make the behavior selectable: abandon or block.
>>>
>>
>>Well, the driver already was trying to opperate in the mode where it was 
>>abandoning bytes, it was just doing a bad job of it.  All I did was fix 
>>it so it actually abandoned all bytes that didn't fit in the buffers.
>>
>>Before it was grabbing a byte from snd_rawmidi_transmit() and if no room 
>>was in the buffer it would break out of the while(1) loop.  So, 
>>basically it would abandon the first byte on its execution, but leave 
>>some data there for later.  This caused a problem with rawmidi's buffers 
>>seeming to back up and eventually hanging up the driver (recoverable 
>>only via reopening the device).
> 
> 
> basically, the data should NOT be abandoned as long as it can be
> held.  the current code is not good from this perspective.
> it should be something like:
> 
> 	while (snd_rawmidi_transmit_peek(substream, &byte, 1) == 1) {
> 		if (! writable())
> 			break;
> 		write_byte(byte);
> 		snd_rawmidi_transmit_ack(substream, 1);
> 	}
> 

So, should the driver not be using the snd_rawmidi_transmit() function, 
and instead doing its own thing.  Perhaps this would be more proper and 
would make it work better.  It'll require a larger re-work of the 
relevant driver function, but I think it'll be worth it.

> 
>>The program (call it pdr) we have using this device operates in blocking 
>>mode.  So, if things worked properly, pdr would attempt to write the 
>>midi msg, and the snd_seq_event_output() just wouldn't return until it 
>>was able to send the data.  That would be fine.  BUT, if we physically 
>>disconnect the serial cable from the device, after awhile, the buffer in 
>>serial-u16550.c fills up, then one byte is retrieved from 
>>snd_rawmidi_transmit() (and then discarded by the driver) for every 
>>three bytes put into the rawmidi buffers, these buffers fill up and 
>>eventually cause the lockup of the driver, all while never reporting a 
>>problem back to pdr (snd_seq_event_output() seems not to block even 
>>though we're in blocking mode).
> 
> 
> in this case, the operation is blocked because it's really blocked.
> sure, it doesn't report errors because it's just the blocking
> behavior.  the driver doesn't detect the disconnection, and it simply
> waits until the next transfer is available.

I don't think you're understanding what I'm telling you.  pdr doesn't 
get blocked even though we don't set SND_SEQ_NONBLOCK mode on.  It calls 
the snd_seq_event_output() and that ALWAYS returns.  In the condition 
that the buffer fills up, and then the system is reconnected and drains 
the buffer, after that any more writes that pdr sends out that go 
through rawmidi's buffers never happen.  All send direct output will 
still work however.

It really doesn't matter to our app if it gets blocked or is not blocked 
or if bytes get discarded during a physical cable disconnection, the way 
it is designed it continues to grind on anyway and as such, when 
reconnected and the buffer drains eventually all would be right with the 
world again.  BUT, something in Alsa breaks down in this instance and 
doesn't just clear up.  It drains the buffers, but after that no more 
data that gets routed through the buffers ever ends up in the driver. 
Send direct events do get through to the driver and sent out over the wire.

So, right now, having the driver not discard bytes when it's buffer is 
full will cause rawmidi's buffers to fill up.  At that point the 
subsystem is locked up forever, at least until it is reset.  Even the 
reconnection and draining of the buffers keeps it locked up.

Basically, what I've done is as much a work-around as anything else.  I 
make it so that data never can back up in rawmidi's buffers.  Hence, 
when we plug the system back in, after the serial driver buffers get 
cleared out, new data can get through to the device.

>>However, if we want different behavior, let me know how to do this.  I 
>>was able to fix the problem here, without digging further into the 
>>rawmidi code or even further up the chain.  Frankly I'm not educated 
>>enough on that code to safely mess with it.  To handle a "blocking" 
>>mode, the driver would need some way to properly communicate it is full 
>>to rawmidi.  This could be either some method to do this specfically, or 
>>just that rawmidi's buffer doesn't get emptied.  But, at this time, that 
>>seems to cause a problem.
> 
> 
> my opinion is that it's bad behavior to abandon the data IMMEDIATELY
> when the local buffer is full.  this situation can happen quite easily
> when you send a large bulk data.  the uart's local buffer will be full
> soon, then the successding data will be simply lost.

This is a good point.  Though as the buffer is about 32k, we don't ever 
see this problem, I do acknowledge  that it is a potential problem. 
Didn't think about it since we don't see this issue.

> 
> it's true that in some special cases, we need to reset the device.  
> but, as far as i understand, the buffer-full is not the criteria of
> the reset, since it may happen even with the normal operation.
> 

I agree, hence why I called it a _hack_ and looked for a better solution.

> maybe it'd be better to add a timeout for the sanity check.  firstly
> after the time out is detected, we can do some reset work on the
> device, e.g. flush the buffer, etc.
> (the communication over the ALSA sequencer is a different story,
> though...)
> 

eep!  I'm not sure I want to get into figuring out a timeout thingy... 
Maybe better left to the application level, where the app can decide 
that after getting some count of -EAGAIN responses in non-blocking mode 
it can give up or send some sort of flush/reset command to the alsa system.

> well, until this is implemented, we can add the switch (e.g. a module
> parameter) for your behavior (ignore-buffer-overflow), so that the
> driver works at least for your purpose...
> 

Ok, but I'd rather find the root of the problem and come up with a clean 
solution than depend on a special switch.  I'll work on it a little and 
propose a slightly different patch.  Maybe I'll rework 
snd_uart16550_output_write() a bit more drastically so that it works 
better.  Though I'm not sure what I can do to it that doesn't drop bytes 
yet doesn't seem to lockup the rawmidi stuff by not removing data from 
rawmidi buffers.  If I can't find another way, I'll put in the parameter 
as a work around until we can find a better fix.

I'll work on this for a bit this week and propose a second patch.  If 
you can come up with any ideas of things to look at or other issues, let 
me know.

Thanks,
- Steve



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
