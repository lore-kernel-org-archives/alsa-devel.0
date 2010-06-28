From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: pcm_lib: avoid timing jitter in
	snd_pcm_read/write()
Date: Mon, 28 Jun 2010 11:13:49 +0800
Message-ID: <AANLkTillC6b8uGRt9GFyq81M9KNxEneeTsdU6b6UfaSw@mail.gmail.com>
References: <1277590400.2438.15.camel@obelisk.thedillows.org>
	<AANLkTil91moJgRh51QFgvSFd47MzQxzxty1H2RzKK5nF@mail.gmail.com>
	<1277648967.2438.32.camel@obelisk.thedillows.org>
	<alpine.LNX.2.00.1006271942500.15497@eeebox2.perex-int.cz>
	<1277678773.2438.103.camel@obelisk.thedillows.org>
	<AANLkTimO0L-JL3zVg_ZzU7kWK6ez0CwwlR839K_X7MGz@mail.gmail.com>
	<1277690630.2438.149.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EF80C1037F7
	for <alsa-devel@alsa-project.org>;
	Mon, 28 Jun 2010 05:13:50 +0200 (CEST)
Received: by vws11 with SMTP id 11so2789564vws.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2010 20:13:50 -0700 (PDT)
In-Reply-To: <1277690630.2438.149.camel@obelisk.thedillows.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Dillow <dave@thedillows.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/6/28 David Dillow <dave@thedillows.org>

>
>
> On Mon, 2010-06-28 at 08:37 +0800, Raymond Yau wrote:
> > 2010/6/28 David Dillow <dave@thedillows.org>
> > > Perhaps documentation that recommends setting avail_min to 1 when using
> > > read/write to avoid this issue would be helpful, in lieu of changing
> the
> > > ALSA code or giving concrete guarantees.
> > >
> > > Dave
> > >
> > >
> > Refer to
> > http://article.gmane.org/gmane.linux.alsa.devel/69333/match=avail_min
> >
> > avail_min cannot be less than period size , however set_avail_min() did
> not
> > return any error when the value is less than period size and this mislead
> > the programmers to believe that they can set avail_min to 1
>
> They used to be able to, and it would work. You likely cannot get
> latency that low, but anyone that was expecting for that to magically
> change the way hardware works is fooling themselves. avail_min is like
> the timeout argument to poll() -- you're guaranteed at least that value,
> but you may get something much larger.
>
> I understand the rationale given for patch b0b7d0 to alsa-lib, but
> limiting avail_min in this way removed a workaround for the muddled
> snd_pcm_read/write() semantics. I suppose it is still possible, if
> someone wants to color outside libasound -- the kernel still allows it.
>
> > if you want low latency, you need to use small period size
>
> Small period sizes are often needed for low latency -- 10ms is common
> for VoIP -- but if you are stuck with a device that can only do two
> periods per buffer, the current read/write code will cause unstable
> audio with frequent overruns. You can add another round trip to the
> kernel with snd_pcm_wait(), but that's suboptimal and should not be
> required.
>
> You can get reasonably good stability on limited devices with avail_min
> == 1, or with a read/write that doesn't force you to wait two periods
> when trying to work with one.
>
> Dave
>
>
The audio data record at the sample rate by ac97codec through ac97link to
ac97 controller

e.g. cs46xx use  snd_pcm_indirect_capture_transfer()

it is unlikely to set avail_min or minimum period size to a value less than
the PCI brust size if your driver are using DMA  transfer

you cannot set avail_min to 1 unless your period_size is 1 because

	if (val < pcm->period_size)
		val = pcm->period_size;



http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=b0b7d0280f977dee1bbff0a1b4cd0c50068d2371;hp=1cf37d72c4e77fac55f2b1792bdcf12744a5a51a


int snd_pcm_sw_params_set_avail_min(snd_pcm_t *pcm, snd_pcm_sw_params_t
*params, snd_pcm_uframes_t val)

#endif
{
	assert(pcm && params);
	/* Fix avail_min if it's below period size.  The period_size
	 * defines the minimal wake-up timing accuracy, so it doesn't
	 * make sense to set below that.
	 */
	if (val < pcm->period_size)
		val = pcm->period_size;
	params->avail_min = val;
	return 0;
}
