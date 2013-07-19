From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [RFC][PATCH 0/4] firewire-lib: add payload
 callback function for each driver
Date: Fri, 19 Jul 2013 23:13:55 +0900
Message-ID: <51E949A3.3040401@sakamocchi.jp>
References: <1374061848-5851-1-git-send-email-o-takashi@sakamocchi.jp>
 <51E82800.80201@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp301.phy.lolipop.jp (smtp301.phy.lolipop.jp [210.157.22.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F4D22652CC
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 16:14:04 +0200 (CEST)
In-Reply-To: <51E82800.80201@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: robert.chamier@googlemail.com, damien@zamaudio.com, linux1394-devel@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens,

Thanks for your comments.

 > But Fireworks accepts AM824 labels, and recognizing 0x00 labels is no
 > problem.

Yes. In our experiences, there may be no problem. But I'm concern about 
the side effect and want to use no labels if possible.

 > Right now I'm working on merging the playback-only snd-dice driver
 > (without the M-Audio code, which doesn't work) into the kernel,
 > restricted to Weiss devices (they asked for this).
 >
 > (Setting the pcm_quadlets/midi_quadlets arrays for dual-wire mode is
 > to be moved into snd-dice.)

I think Dice has no SYT-Match mode then the driver need to generate syt 
for out-stream from the value in in-stream. How do you solve this or 
Weiss devices don't need this synchronization?

By the way, I did most of implements for this mechanism so hope you to 
review my patches for it when you have enough time.

 > I removed S16 because I did not want to duplicate most of the sample
 > writing code, and format conversion should be done in userspace.  This
 > would be a regression for users of the snd-firewire-speakers driver
 > (both of them), so I'm not sure if I should keep this.
 >
 > Do you have a specific reason for wanting S16 support?

I just follow the idea to implement functions which the device has. I 
have no special reason. But I note that BeBoB supports 20 bit sample, too.

 > Why?  Because many device quirks must be handled in amdtp.c?
 >
 > Having separate write_samples() implementations would duplicate most
 > of the code in those loops, which I do not think would be better for
 > maintenance purposes.

I assume bad case in which the amdtp.c has many quirks and the effects 
generate conflict to each driver and many conditions brought longer time 
and much complexicy to shared code.

 > I don't understand; how is this related with the payload processing?

I'm sorry. It's not related to MIDI stream...

The amdtp_out_stream_set_pcm_format() is used to set the function to 
write samples. Here can we add condition to set it referring the value 
of format in PCM runtime instead ot the function. Then function is 
automatically selected and each driver don't consider it.

 > I'm not sure if a separate write_samples() function is appropriate for
 > this; couldn't this be handled by an additional function that is
 > called before or afterwards?

This is better. If I had no idea about this separate write_samples(), I 
will have applied this way.

 > These patches are not self-contained, i.e., the driver does not work
 > if only some of them are applied (this happens, e.g., when bisecting).

I realize it. I follow a idea to keep the size of patch small. Next time 
I'm OK to make them self-contained. Thanks to indicate it.

 > Despite my criticisms above,  if you think that these patches are
 > necessary for your driver(s), I'm not against merging them.

I have no will to do it against your criticisms.


Thanks

Takashi Sakamoto

(Jun 19 2013 02:38), Clemens Ladisch wrote:
> Takashi Sakamoto wrote:
>> Currently snd-firewire-lib handles the contents of data block for AMDTP packet
>> in itself.
>>
>> But to implement drivers for Fireworks(Echo Audio)/BeBoB(BridgeCo), there is an
>> inconvinience. Fireworks don't use AM824 label for PCM data.
>
> But Fireworks accepts AM824 labels, and recognizing 0x00 labels is no
> problem.
>
>> BeBoB needs to remap PCM and MIDI channels depending on devices.
>>
>> And Dice(TC Applied Technologies) - I think you understand this than me - needs
>> the mode called as "dual wire".
>> Your snd-firewire-lib in alsa-kprivate.git repository manages to solve these
>> issue.
>
> Right now I'm working on merging the playback-only snd-dice driver
> (without the M-Audio code, which doesn't work) into the kernel,
> restricted to Weiss devices (they asked for this).
>
> (Setting the pcm_quadlets/midi_quadlets arrays for dual-wire mode is to
> be moved into snd-dice.)
>
>> But it has restriction about the PCM format (S32 only)
>
> I removed S16 because I did not want to duplicate most of the sample
> writing code, and format conversion should be done in userspace.  This
> would be a regression for users of the snd-firewire-speakers driver
> (both of them), so I'm not sure if I should keep this.
>
> Do you have a specific reason for wanting S16 support?
>
>> and for me it seems to be hard to maintain.
>
> Why?  Because many device quirks must be handled in amdtp.c?
>
> Having separate write_samples() implementations would duplicate most of
> the code in those loops, which I do not think would be better for
> maintenance purposes.
>
>> Additionally to implement full duplex with synchronization, I need to restart
>> streams for MIDI. Then current amdtp_out_stream_set_pcm_format() is not
>> convinient. I want to add condition for PCM format into each drivers.
>
> I don't understand; how is this related with the payload processing?
>
>> Furthermore, 003Rack(Digidesign) - I don't work for this - has more issue. The
>> differences related to payload are:
>>   - the value of syt field in AMDTP packet is always zero
>
> This does not affect the driver.
>
>>   - The data in each channel is encoded by its own way
>> The driver needs to refer to and modify the contents of payload.
>
> I'm not sure if a separate write_samples() function is appropriate for
> this; couldn't this be handled by an additional function that is called
> before or afterwards?
>
>> To solve these device-dependent issues, I want to move the processing
>> of contents in payload from firewire-lib to each devices. This series of
>> patches is for this purpose.
>
> Despite my criticisms above,  if you think that these patches are
> necessary for your driver(s), I'm not against merging them.
>
>> sakamocchi (4):
>>    firewire-lib: add helper function to set data block size
>>    firewire-lib: add callback function for payload
>>    firewire-lib: remove unused members and functions
>>    firewire-speakers: add functions to handle payload
>
> These patches are not self-contained, i.e., the driver does not work if
> only some of them are applied (this happens, e.g., when bisecting).
>
>
> Regards,
> Clemens
