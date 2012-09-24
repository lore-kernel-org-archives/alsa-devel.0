From: Jeff Robins <jeffrobinssae@gmail.com>
Subject: Re: snd_had_intel turning off internal speakers by
 going to power state D3
Date: Mon, 24 Sep 2012 12:03:42 -0700
Message-ID: <CAHC-z7L27C5+TeodDUtRykXtd2FkTS2PE6tZ5PSEBmXyBswZQQ@mail.gmail.com>
References: <CAHC-z7LoXwhyx7mM4Q+j9kTUdLo3wajNcETUVUbw_K+Nc6_eAA@mail.gmail.com>
 <s5hr4pronex.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A92772616C6
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 21:03:43 +0200 (CEST)
Received: by pbbrp16 with SMTP id rp16so2561838pbb.38
 for <alsa-devel@alsa-project.org>; Mon, 24 Sep 2012 12:03:42 -0700 (PDT)
In-Reply-To: <s5hr4pronex.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 24, 2012 at 1:06 AM, Takashi Iwai <tiwai@suse.de> wrote:
> At Sat, 22 Sep 2012 13:03:37 -0700,
> Jeff Robins wrote:
>>
>> Hello,
>>
>> I have a Toshiba Satellite C655D with Mageia 2 and I have a problem
>> where the internal speakers eventually stop producing sound, but the
>> headphones still work.  After doing a bit of research and running
>> alsa-info (attached) I figured out that one of the parts of the sound
>> card
>> had gone into a D3 power state.
>>
>> Removing and then reloading the snd_hda_intel module fixed the
>> problem, but then the sound would turn off again.  I was able to find
>> a post
>> in alsa-users where someone else came up with a better solution using
>> hda-verb to reset the power state:
>> http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg28769.html
>>
>> I also found a thread in the gentoo forums where other people are
>> having the same problem.  One of them has kernel 3.5.0:
>> http://forums.gentoo.org/viewtopic-t-932038.html?sid=2bee6543c63f2342057c71bc876e7273
>>
>> I'm open to compiling my own alsa and helping out in any way I can.
>> Please let me know what I can do.
>>
>> Mageia bug report for completeness:
>> https://bugs.mageia.org/show_bug.cgi?id=7292
>
> OK, it's getting interesting now.
> We've got similar reports but so far only on Lenovo laptops with the
> Conexant codecs.  (I'm not quite sure whether all are with CX20585.
> Might be with other Conexant variants?)
>
> I asked Conexant guys to check this issue, and they informed that
> there is no automatic-go-to-D3 feature in the codec hardware itself.
> And judging from the hardware state, it looks like the class-D speaker
> goes down due to the over temperature.  So, we concluded that this
> should be very likely Lenovo-specific things.
>
> But now you reported about Toshiba laptop.  It brings up again the
> possibility of the sound driver side...  Weird.
>
> Can it be a regression since some kernel version?  The kernel
> regression doesn't mean necessarily a sound driver regression but
> might be a problem in another part like ACPI, too.
>
>
> thanks,
>
> Takashi

This never happened with Mageia 1 and I don't think it happened
originally with Mageia 2, but started after updates.  I was looking
into a problem with there being no sound after a hibernation, when my
wife told me about the current problem.

I will try to get you the current kernel version of Mageia 1 tonight,
but it has been a while since I upgraded to 2.  I will also play the
sound
for a long period in Windows to see if I have a problem there, in case
it is temperature related.  We never use Windows, so I don't actually
know how it acts there.

Thank you,

Jeff
