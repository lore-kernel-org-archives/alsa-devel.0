From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: hw_ptr accuracy with intel8x0 -> PulseAudio issue
Date: Wed, 9 Dec 2009 19:55:15 +0800
Message-ID: <4f3252890912090355n70a2b5cfu4fbb74d473480a94@mail.gmail.com>
References: <6160a5130912020115t45bd4635hceb0ac3de4fb1efe@mail.gmail.com>
	<4f3252890912021826g732292ecv8959a7cfbf574446@mail.gmail.com>
	<6160a5130912030828m5b2401f3w31a67b6b51e8d8b6@mail.gmail.com>
	<4f3252890912031442i56ccc905g935a4d6ed48f40c6@mail.gmail.com>
	<6160a5130912031650u5949c921jc86d0847b2844803@mail.gmail.com>
	<4f3252890912041817u7ab83a3eh7643476d64d709f3@mail.gmail.com>
	<s5h4oo1sisn.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F6451037F2
	for <alsa-devel@alsa-project.org>; Wed,  9 Dec 2009 12:55:16 +0100 (CET)
Received: by pwi11 with SMTP id 11so3772154pwi.32
	for <alsa-devel@alsa-project.org>; Wed, 09 Dec 2009 03:55:15 -0800 (PST)
In-Reply-To: <s5h4oo1sisn.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/12/8 Takashi Iwai <tiwai@suse.de>

> At Sat, 5 Dec 2009 10:17:07 +0800,
> Raymond Yau wrote:
> >
> > 2009/12/4 pl bossart <bossart.nospam@gmail.com>
> >
> > > >>   17. hwptr 24351 buffer 16384 appl 24332, avail=16403
> > > >
> > > > appl pointer is behind hwprtr (  underrun ) , need timestamp to find
> out
> > > > whether PA is unable to write audio data in time since
> > >
> > >  I commented out the portion of the code that increases the watermark
> and
> > > clamped the number of available samples to the buffer size, and it
> works
> > > just fine, no audio
> > > underflows.
> > >
> >
> > Do you mean that the underrun is related the the portion of code that
> > increase the watermark (i.e It is a pulseaudio bug instead of driver bug
>  )
> > ?
>
> Or, we can try simply to change to periods_min = 2 whether this fixes
> the PA issues.
>
> periods_min = 1 is anyway fairly fragile.  With that setup, apps are
> supposed (implicitly) to wake up frequently enough to get pointers in
> sync.  This is because you can't trust whether the IRQ wake up is
> really fast enough.  There are machines that aren't.
>
>
> thanks,
>
> Takashi
>

The intel8x0 driver has code to handle one period per buffer ,

Is the feature "one period per buffer"  designed for dmix ?

static void snd_intel8x0_setup_periods(struct intel8x0 *chip, struct
ichdev *ichdev)
{
	int idx;
	u32 *bdbar = ichdev->bdbar;
	unsigned long port = ichdev->reg_offset;

	iputdword(chip, port + ICH_REG_OFF_BDBAR, ichdev->bdbar_addr);
	if (ichdev->size == ichdev->fragsize) {
		ichdev->ack_reload = ichdev->ack = 2;
		ichdev->fragsize1 = ichdev->fragsize >> 1;
		for (idx = 0; idx < (ICH_REG_LVI_MASK + 1) * 2; idx += 4) {
			bdbar[idx + 0] = cpu_to_le32(ichdev->physbuf);
			bdbar[idx + 1] = cpu_to_le32(0x80000000 | /* interrupt on completion */
						     ichdev->fragsize1 >> ichdev->pos_shift);
			bdbar[idx + 2] = cpu_to_le32(ichdev->physbuf + (ichdev->size >> 1));
			bdbar[idx + 3] = cpu_to_le32(0x80000000 | /* interrupt on completion */
						     ichdev->fragsize1 >> ichdev->pos_shift);
		}
		ichdev->frags = 2;
	} else {

The system timer may be running faster or slower than the sound card
on differnt machine

PA only adjust the watermark/sleeping time in one direction only
