From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: [PATCH] serial-u16550 driver.  Fixes buffer blocking
 bug
Date: Thu, 30 Oct 2003 13:33:37 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FA183B1.3090706@pianodisc.com>
References: <3FA03585.1000901@pianodisc.com> <s5hn0biyj9z.wl@alsa2.suse.de>
Reply-To: derosier@pianodisc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hn0biyj9z.wl@alsa2.suse.de>
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

Takashi,

Thanks for your response.  I've addressed your issues below.  Let's 
discuss this and if necessary I'll modify my fix.

>>1. Move all checks of buffer overflow and such to the 
>>actual buffer write and read routines.  This makes
>>the buffer routines more robust and encaspulates buffer
>>opperations better.
> 
> 
> the check in the caller may be still needed for the multi-bytes write
> (e.g. for switching the port).  otherwise, the port-switch command
> can be mixed and messed up when the device is accessed concurrently.
> 

I thought about this, but decided it's not a large issue since it is 
mitigated by the natural operation of the driver.
For normal opperation:  As this is called with interupts off, the 
process can't be interupted.  The function doesn't return until after 
we've drained the snd_rawmidi_transmit(), and if we do decide to insert 
a "f5..." msg, we do the whole msg before we can return.  So, no issue 
durring normal opperation.  So concurrent access doesn't apear to be a 
large issue.

If buffer gets full:  Yes, it is possible for an "f5..." msg to get 
interupted.  BUT, I don't see this as a large problem.  On return to 
normal opperation (ie. the buffer begins draining again), the proper 
port-switch command will be written in correctly when the port gets 
switched, or in the next three seconds, whichever comes first.  Perhaps 
some data gets sent to the wrong port, but it autocorrects very quickly. 
While this condition technically is possible, I haven't seen it happen 
in practice, and even if it does it would correct itself quickly. For 
another mittigating factor, please see my answer to #2 below.

If you're still concerned about this, I have an alternate fix that would 
keep a check, but not interfeare with opperation.

> 
>>2. Always try to send data to the buffers.  Don't interupt
>>normal opperation of the algoritim because buffers are full.
>>This was what was actually causing the data to be left in 
>>rawmidi and thus causing it to lock up.  This is helped
>>by moving the buffer size checks into the routines.
> 
> 
> this is the questionary behavior.
> the fact that the local buffer is full means that the transfer doesn't
> work.  so, it is quite correct behavior that rawmidi blocks the
> further write (in blocking mode), i think.  and, it should return
> -EAGAIN in non-blocking mode.
> or, at least, we can make the behavior selectable: abandon or block.
> 

Well, the driver already was trying to opperate in the mode where it was 
abandoning bytes, it was just doing a bad job of it.  All I did was fix 
it so it actually abandoned all bytes that didn't fit in the buffers.

Before it was grabbing a byte from snd_rawmidi_transmit() and if no room 
was in the buffer it would break out of the while(1) loop.  So, 
basically it would abandon the first byte on its execution, but leave 
some data there for later.  This caused a problem with rawmidi's buffers 
seeming to back up and eventually hanging up the driver (recoverable 
only via reopening the device).

The program (call it pdr) we have using this device operates in blocking 
mode.  So, if things worked properly, pdr would attempt to write the 
midi msg, and the snd_seq_event_output() just wouldn't return until it 
was able to send the data.  That would be fine.  BUT, if we physically 
disconnect the serial cable from the device, after awhile, the buffer in 
serial-u16550.c fills up, then one byte is retrieved from 
snd_rawmidi_transmit() (and then discarded by the driver) for every 
three bytes put into the rawmidi buffers, these buffers fill up and 
eventually cause the lockup of the driver, all while never reporting a 
problem back to pdr (snd_seq_event_output() seems not to block even 
though we're in blocking mode).  As far as pdr seems to know, it's able 
to always send data, but eventually the data stops getting to the 
physical device (as a side note, midi data that avoids the rawmidi 
buffers via snd_seq_event_output_direct() will get written to the device 
properly even in this case).

So, now the driver reliably drops all data given to it if the buffers 
are full, not just some of the data and rawmidi buffers never get backed 
up, the driver doesn't lockup and everything works properly when the 
device gets pluged back in.

Personally, I feel it IS proper behavior.  Simple fact is, if the 
condition happens where this buffer gets filled in, the midi events have 
been "released" by alsa to go out to the device immedately, but have now 
been delayed by up to 30-40 minutes.  They're past their prime and are 
really no longer relevant.  If we discard data, well, tough.  At this 
point it becomes about error recovery, not valid data.  This code 
recovers proper opperation, where the old code didn't.  This method 
works best for our application.

However, if we want different behavior, let me know how to do this.  I 
was able to fix the problem here, without digging further into the 
rawmidi code or even further up the chain.  Frankly I'm not educated 
enough on that code to safely mess with it.  To handle a "blocking" 
mode, the driver would need some way to properly communicate it is full 
to rawmidi.  This could be either some method to do this specfically, or 
just that rawmidi's buffer doesn't get emptied.  But, at this time, that 
seems to cause a problem.

Granted, my opinion that this is the proper operation is just my 
perspective--it does what we want for our devices.  Is it generally 
applicable to everyone that uses this driver?  Maybe or maybe not.  I'll 
trust that you know more than me about the general purposes of this 
stuff and how it fits in the overall alsa archetecture.

> the problem is that there is no way to reset the device except for
> reopening the device.  although there is a drop ioctl for rawmidi, it
> doesn't reset the device as expected but only flushes the rawmidi
> buffer.
> 

Earlier while I was working to solve this problem with the driver, I 
hacked in a solultion that fixed it, but it was a horrible hack. 
Basically, in snd_uart16550_write_buffer() I made it so if the buffer 
was full and it attempted to write a byte into it, the driver would 
reset the buffer.  Basically:

inline static void snd_uart16550_write_buffer(snd_uart16550_t *uart, 
unsigned char byte)
{
	unsigned short buff_in = uart->buff_in;
	if( uart->buff_in_count < TX_BUFF_SIZE )
	{
	        uart->tx_buff[buff_in] = byte;
	        buff_in++;
	        buff_in &= TX_BUFF_MASK;
	        uart->buff_in = buff_in;
	        uart->buff_in_count++;
	        if (uart->irq < 0) /* polling mode */
	                snd_uart16550_add_timer(uart);
	}
         else
         {
           uart->buff_in = 0;
           uart->buf_in_count = 0;
           uart->buff_out = 0;
         }
}

As I said, this was an ugly HACK.  But, it fixed the immedate problem we 
were having by resetting buffers, and gave me one of my first hints as 
to the real problems.  I went on from there and eventually came up with 
the patch I sent in.  (I've been working on this specific problem for 
roughly 4-6 weeks now, so I've gone through a lot of detail on what 
works or doesn't and why.  And I'm very familar with the snd_uart16550.c 
code now.)

Maybe if there was some hook so that the snd_uart16550 driver itself 
could get reset?

>>3. When able to write, drain output as necessary instead of
>>only writing one byte at a time.  This was causing us to 
>>backup eventually anyway since we usually write more than 
>>one byte of data.
> 
> 
> looking at the code, only MS124W_SA and GENERIC types don't do loop.
> so, it might be intentional, although i don't see any reason against
> the looping.
> 

I talked w/ the person who said he added that if(...) in there in the 
first place and I was told it wasn't intentional.  So I think that the 
loop should be fine and it makes it more consistant with the second 
clause.  BTW, we're using the GENERIC type.  Not having the loop 
actually caused a secondary problem.

> 
> btw, please use the unified diff (-u) as the patch at the next time.
> it's much more readable.
> 
Sure, not a problem.  BTW, there doesn't seem to be anywhere on the alsa 
web site (and no mention in alsa docs or readme) of what patch format to 
use.  I researched it for quite awhile and then gave up and just used 
the form that GNU's GCC project says to use 
(http://www.gnu.org/software/gcc/contribute.html#patches).  I'm a past 
contributer of GCC and Binutils, so I just fell back on what I'm used 
to.  What is the Alsa project's offical format?  -u? -up?

I know that this is alot of info, but I've been working on this problem 
for quite awhile now and frankly it is simply a lot of info.  I'm hoping 
that it will allow us to either banter this back and forth enough to 
come to an agrement and then another acceptable fix that works for both 
of us, or reassure you that my patch is good enough to commit.

Thanks,
- Steve



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
