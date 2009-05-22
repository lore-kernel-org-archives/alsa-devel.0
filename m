From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: more on appl_ptr and DMA overrun at end of stream
Date: Fri, 22 May 2009 09:58:29 -0400
Message-ID: <9e4733910905220658x5154c950q258680071f755754@mail.gmail.com>
References: <9e4733910905211144mfdc2947mbeb8872affb201cf@mail.gmail.com>
	<s5h1vqhhc77.wl%tiwai@suse.de>
	<alpine.LNX.2.00.0905220902570.4067@eeebox2.perex-int.cz>
	<s5htz3dfw2j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id C8968103913
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 15:58:33 +0200 (CEST)
Received: by qyk1 with SMTP id 1so2585571qyk.16
	for <alsa-devel@alsa-project.org>; Fri, 22 May 2009 06:58:30 -0700 (PDT)
In-Reply-To: <s5htz3dfw2j.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, May 22, 2009 at 3:14 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Fri, 22 May 2009 09:07:43 +0200 (CEST),
> Jaroslav Kysela wrote:
>>
>> On Fri, 22 May 2009, Takashi Iwai wrote:
>>
>> > At Thu, 21 May 2009 14:44:27 -0400,
>> > Jon Smirl wrote:
>> >>
>> >> I've been reading Lennart's article on glitch free audio....
>> >>
>> >> On my scatter/gather DMA hardware I generate an interrupt at the end
>> >> of each period. On the last period this causes ALSA to issue a
>> >> trigger(STOP). However, there is a latency from when that interrupt is
>> >> generated and when ALSA does the trigger(STOP). During that latency my
>> >> hardware starts playing the next buffer (which contains stale data).
>> >> Playing stale data causes a noise burst. I fixed this by programming
>> >> my DMA hardware to not overrun appl_ptr.
>> >>
>> >> There's another solution. ALSA already knows the stream ends
>> >> mid-period and pads out the partial period with silence. If it simply
>> >> padded out the next period with silence too the overrun problem would
>> >> become non-audible and there would time to process trigger(STOP).
>> >>
>> >> If padding out two periods at end of stream is possible, it then
>> >> becomes possible for me to turn off interrupts in my audio driver.
>> >
>> > This can be another interesting feature. =A0For example, you could add
>> > a soft-mute padding to avoid a click noise at the end instead of a
>> > whole silence.
>> >
>> > But, this kind of hack really depends on the hardware implementation.
>> > If a hardware has no DMA but require explicit writes, adding two
>> > periods is too much. =A0Just a few samples would be enough.
>>
>> I agree to leave such things to lowlevel drivers.

The core problem is that the lowlevel driver does not have sufficient
information to know where the end of stream is.  If ALSA just told me
the end address of the stream I'd program the DMA hardware to stop
after the last sample played. I can easily program the hardware to
play a partially filled period. Instead I have to take interrupts and
go looking for the address of end of stream. I can usually get that
info from appl_ptr but there are modes where appl_ptr doesn't provide
end of stream.

trigger(stop) is worthless in that I receive it long after I needed to
stop playing. How am I supposed to make trigger(stop) work? Last
period plays and has been padded with silence. I get an interrupt when
it is done. Unless there is zero latency (which there is not) I am
going to start playing the next period before trigger(stop) can turn
me off. This period is always full of stale data and it always makes a
noise burst.

>>
>> > Or, in the case of normal PCI DMA transfer, how can it be stopped?
>> > That is, the stream is still running although it's claimed to be
>> > stopped. =A0If a period size is big (say over one second), the stop at
>> > the next interrupt doesn't sound good.
>>
>> I would suggest to improve drain() logic in kernel with
>> snd_pcm_update_hw_ptr() calls and using proper timeouts for
>> schedule_timeout().
>>
>> Note that this situation were handled with dead and removed pcm tick API=
 -
>> although it required assistance (setup) from application.
>
> ... and, the results was no one used it :)
> Apps don't want to set up such details at all -- that's the lesson
> we had to learn...
>
>
> Takashi
>



-- =

Jon Smirl
jonsmirl@gmail.com
