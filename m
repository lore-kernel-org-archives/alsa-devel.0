From: Daniel Mack <daniel@caiaq.de>
Subject: Re: driver for Native Instruments' audio devices
Date: Fri, 7 Apr 2006 17:28:26 +0200
Message-ID: <682B56E8-722E-4DD2-8906-82DD831E19BB@caiaq.de>
References: <2C67C334-1C47-497E-87CB-974D1853F3FF@caiaq.de> <20060407092432.GB4670@turing.informatik.uni-halle.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060407092432.GB4670@turing.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Clemens,

thanks for your response.

On Apr 7, 2006, at 11:24 AM, Clemens Ladisch wrote:

>> +static void stream_start(void *d)
>> ...
>> +		ret = usb_submit_urb(dev->data_urbs_in[i], GFP_KERNEL);
>> +		if (ret < 0)
>> +			log("unable to trigger initial read #%d! (ret = %d)\n", i, ret);
>
> You should abort with an error if the submit fails.

How would you do that? As I must not block in the trigger callback,  
things
have to be done by a work_struct. How could I report an error from  
within this
context? What behaviour does ALSA expect from a driver running into  
such a
problem?

> I'm not sure that implementing pausing in this way is correct --  
> killing
> the URBs will throw away some data instead of stopping at the current
> position.

Ok, I see your point. Because the hardware works in a way that the input
stream defines the audio clock speed and because both the input  
stream and
the output stream need to be running at any time, I have to work around
this issue.

> What happens when both playback and capture streams are used?

Now, stopping one stream will not shut down the whole streaming
anymore but simply ignore the substream. Only if both the input
and the ouput stream is stopped, the urbs will be killed.

Pausing will never influence the streaming anymore, the engine will just
not move forward in the audio buffer but send/receive dummy data for  
this
particular stream instead.

> I think additional streams should be made available as separate PCM
> devices and not as substreams, because those streams would be
> independent of each other.

Hmm, no. 'streams' simply means one stereo audio pair. They will always
be in sync to each other since the hardware only has one clock domain.

> Are there any devices with more than one stream?

In the way we use this term, yes. The Kore Controller has a seperate
headphone output and some other, new upcoming devices will also have
more than one stereo input.

>> +++ alsa-kernel/usb/caiaq/caiaq-midi.c
>> +int __devinit snd_usb_caiaq_midi_init(struct snd_usb_caiaqdev  
>> *device)
>> +	ret = snd_rawmidi_new(device->chip.card, device->product_name, 0,
>> +					device->spec.num_midi_out,
>> +					device->spec.num_midi_in,
>> +					&rmidi);
>
> Are there devices with more than one MIDI port?

Not right now, but there might be in the future. And the protocol  
supports
it, so why don't implement it that way.

>> +	rmidi->info_flags = SNDRV_RAWMIDI_INFO_DUPLEX;
>
> INFO_DUPLEX only makes sense when both _OUTPUT and _INPUT are set.

But does it harm if it's set anyway?

I'll have a new patchset ready soon.

Daniel



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
