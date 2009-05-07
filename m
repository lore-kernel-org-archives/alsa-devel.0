From: =?iso-8859-1?Q?Kristoffer_Grundstr=F6m?= <khisbra@hotmail.com>
Subject: What about my problem on the Dell Dimension 4550,
 when will that be fixed?
Date: Thu, 7 May 2009 14:58:33 +0200
Message-ID: <COL104-W15AFF217F32807D0D76C26A7670@phx.gbl>
References: <mailman.1.1241690401.24864.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from col0-omc3-s7.col0.hotmail.com (col0-omc3-s7.col0.hotmail.com
	[65.55.34.145]) by alsa0.perex.cz (Postfix) with ESMTP id 99B4B247CE
	for <alsa-devel@alsa-project.org>;
	Thu,  7 May 2009 14:58:34 +0200 (CEST)
In-Reply-To: <mailman.1.1241690401.24864.alsa-devel@alsa-project.org>
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


Yes, as the title says: When will my problem with the ALSA-driver that's displayed here?

 

https://qa.mandriva.com/show_bug.cgi?id=49048


/Kristoffer

 
> From: alsa-devel-request@alsa-project.org
> Subject: Alsa-devel Digest, Vol 27, Issue 23
> To: alsa-devel@alsa-project.org
> Date: Thu, 7 May 2009 12:00:01 +0200
> 
> Send Alsa-devel mailing list submissions to
> alsa-devel@alsa-project.org
> 
> To subscribe or unsubscribe via the World Wide Web, visit
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> or, via email, send a message with subject or body 'help' to
> alsa-devel-request@alsa-project.org
> 
> You can reach the person managing the list at
> alsa-devel-owner@alsa-project.org
> 
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of Alsa-devel digest..."
> 
> 
> Today's Topics:
> 
> 1. Re: Beep sound in the end of audio file (Todd Fischer)
> 2. Re: 2.6.29 regression: left audio channel broken after resume
> from suspend with Intel HDA (Tino Keitel)
> 3. Re: 2.6.29 regression: left audio channel broken after resume
> from suspend with Intel HDA (Justin P. Mattock)
> 4. Re: [PATCH 2/2] ASoC: cs4270: add power management support
> (Mark Brown)
> 5. Re: Master vs. Front/Rear/LFE/... elements (Takashi Iwai)
> 6. Re: Beep sound in the end of audio file (Arun KS)
> 7. Re: Beep sound in the end of audio file (Mark Brown)
> 
> 
> ----------------------------------------------------------------------
> 
> Message: 1
> Date: Wed, 06 May 2009 08:19:49 -0600
> From: Todd Fischer <todd.fischer@ridgerun.com>
> Subject: Re: [alsa-devel] Beep sound in the end of audio file
> To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
> Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
> "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Peter
> Ujfalusi <peter.ujfalusi@nokia.com>
> Message-ID: <1241619589.8928.2038.camel@sax-lx.fischerfamily.org>
> Content-Type: text/plain; charset="UTF-8"
> 
> Hi,
> 
> FWIW: while developing a GSTreamer presentation using a BegleBoard (rev
> C), I noticed the same "tuck" sound. It also occurs a second or two
> after the GST application exits. I assumed it was some power management
> code that was disabling the audio codec after it had gone idle, but
> never looked into it. BeagleBoard also uses TWL4030.
> 
> GST command: gst-launch audiotestsrc freq=1000 num-buffers=100 !
> alsasink
> 
> /proc/version: Linux version 2.6.28-omap1 (ddompe@Aleph) (gcc version
> 4.3.1 (GCC) ) #2 Thu Mar 5 08:55:58 CST 2009
> 
> Code image: http://www.beagleboard.org/~arago/esc/esc2009sj.v12.img.gz
> 
> Todd
> 
> On Wed, 2009-05-06 at 19:30 +0530, Aggarwal, Anuj wrote:
> 
> > > -----Original Message-----
> > > From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com]
> > > Sent: Wednesday, May 06, 2009 11:03 AM
> > > To: Aggarwal, Anuj
> > > Cc: linux-omap@vger.kernel.org; alsa-devel@alsa-project.org
> > > Subject: Re: Beep sound in the end of audio file
> > > 
> > > Hello,
> > > 
> > > On Tuesday 05 May 2009 20:03:57 ext Aggarwal, Anuj wrote:
> > > > Hi,
> > > >
> > > > After playing out any audio file on OMAP3 EVM, having TWL4030 codec,
> > > > I am hearing a beep sound. I have also tried implementing a mute function
> > > > in which I disabled all the inputs/outputs but still that didn't help.
> > > >
> > > > Any idea how this can be avoided?
> > > 
> > > I have not heard from this kind of problem so far, which does not mean, that
> > > it does not exist ;)
> > > Can you describe the beep sound?
> > [Aggarwal, Anuj] It's kind of a "tuck" sound coming in the end, after 1 or 2 seconds.
> > > 
> > > After a quick look I can not pin point the soc board file used with the
> > > omap3evm board. Is it in the tree?
> > [Aggarwal, Anuj] No, it is not. Reason being we already have beagle & 
> > sdp3430 there, which are both similar to omap3evm, which I pushed. 
> > So mine got rejected. We had some discussions on how to handle this
> > scenario but nothing got finalized.
> > > 
> > > Does the beep happens in these cases also (after stopping it with Ctrl+C):
> > > aplay -f dat /dev/zero
> > > aplay -f dat /dev/urandom
> > [Aggarwal, Anuj] Yes, it comes in both the cases.
> > > 
> > > 
> > > CC-ing alsa-devel...
> > > 
> > > >
> > > > Thanks and Regards,
> > > > Anuj Aggarwal
> > > >
> > > > Platform Support Products
> > > > Texas Instruments Incorporated
> > > 
> > > 
> > > --
> > > P?ter
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at http://vger.kernel.org/majordomo-info.html
> 
> 
> ------------------------------
> 
> Message: 2
> Date: Thu, 7 May 2009 00:27:53 +0200
> From: Tino Keitel <tino.keitel@gmx.de>
> Subject: Re: [alsa-devel] 2.6.29 regression: left audio channel broken
> after resume from suspend with Intel HDA
> To: linux-kernel@vger.kernel.org
> Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
> Message-ID: <20090506222753.GA6728@mac.home>
> Content-Type: text/plain; charset=us-ascii
> 
> On Tue, Apr 28, 2009 at 02:23:09 +0200, Tino Keitel wrote:
> 
> [...]
> 
> > I just saw another, major problem: line in doesn't work anymore with
> > 2.6.29 and also 2.6.30-rc3 (no usable input level). It works with
> > 2.6.27.20.
> 
> FYI: I just tried 2.6.28 and line-in was still broken. So the last
> working kernel is 2.6.27.
> 
> Regards,
> Tino
> 
> 
> ------------------------------
> 
> Message: 3
> Date: Thu, 07 May 2009 00:40:37 -0700
> From: "Justin P. Mattock" <justinmattock@gmail.com>
> Subject: Re: [alsa-devel] 2.6.29 regression: left audio channel broken
> after resume from suspend with Intel HDA
> To: Tino Keitel <tino.keitel@gmx.de>
> Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
> linux-kernel@vger.kernel.org
> Message-ID: <1241682037.1864.4.camel@unix>
> Content-Type: text/plain
> 
> On Thu, 2009-05-07 at 09:23 +0200, Tino Keitel wrote:
> > On Thu, May 07, 2009 at 00:27:53 +0200, Tino Keitel wrote:
> > > On Tue, Apr 28, 2009 at 02:23:09 +0200, Tino Keitel wrote:
> > > 
> > > [...]
> > > 
> > > > I just saw another, major problem: line in doesn't work anymore with
> > > > 2.6.29 and also 2.6.30-rc3 (no usable input level). It works with
> > > > 2.6.27.20.
> > > 
> > > FYI: I just tried 2.6.28 and line-in was still broken. So the last
> > > working kernel is 2.6.27.
> > 
> > I tried this:
> > 
> > git bisect start v2.6.28 v2.6.27 sound/pci/hda/patch_sigmatel.c
> > 
> > The result is commit 4f1e6bc3646ab50b8181555ab7e6eeab68b8632a.
> > 
> > I can't use git revert because of conflicts, so I crafted the attached
> > patch against 2.6.30-rc4-00288-g413f81e, and now line-in works.
> > 
> > Regards,
> > Tino
> 
> It's funny you mention left audio broken
> with hda(testing out the imac91.patch,
> works good, but as soon as I boot into osx
> the left audio speaker sounds blown out)
> nice... ehhh...
> 
> (probably nothing of the sort, but
> you never know)
> 
> Justin P. Mattock
> 
> 
> 
> 
> ------------------------------
> 
> Message: 4
> Date: Thu, 7 May 2009 09:02:37 +0100
> From: Mark Brown <broonie@sirena.org.uk>
> Subject: Re: [alsa-devel] [PATCH 2/2] ASoC: cs4270: add power
> management support
> To: Timur Tabi <timur@freescale.com>
> Cc: alsa-devel@alsa-project.org
> Message-ID: <20090507080236.GA4098@sirena.org.uk>
> Content-Type: text/plain; charset=us-ascii
> 
> On Wed, May 06, 2009 at 10:27:19AM -0500, Timur Tabi wrote:
> 
> > Acked-by: Timur Tabi <timur@freescale.com>
> 
> Applied, thanks.
> 
> 
> ------------------------------
> 
> Message: 5
> Date: Thu, 07 May 2009 10:49:22 +0200
> From: Takashi Iwai <tiwai@suse.de>
> Subject: Re: [alsa-devel] Master vs. Front/Rear/LFE/... elements
> To: Lennart Poettering <mznyfn@0pointer.de>
> Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
> Message-ID: <s5hbpq5s3fx.wl%tiwai@suse.de>
> Content-Type: text/plain; charset=US-ASCII
> 
> At Wed, 6 May 2009 19:58:24 +0200,
> Lennart Poettering wrote:
> > 
> > Heya!
> > 
> > Some cards expose 'Master' volume sliders. Others expose seperate
> > (stereo) sliders for 'Front', 'Rear' and so on. I have trouble dealing
> > with them properly in PulseAudio:
> > 
> > First of all, on some cards 'Master' seems not to have any effect on
> > the actual analog output, only 'Front' and friends do. Is this a bug
> > or intended behaviour?
> 
> It's an old feature. AC97 spec gives the "master" volume control only
> for front channels. Thus, old boards with AC97 may inherit this
> policy. (The problem of emu10k1 is partly this.)
> 
> Fixing it isn't too difficult with vmaster stuff in the driver side,
> but this breaks the compatibility, and hard to find the real test
> machines nowadays. In short, "don't touch a working system unless it
> gets broken" phase.
> 
> > Can I assume that 'Master' and 'Front' are
> > always independant?
> 
> No.
> 
> > Secondly, I have trouble supporting the
> > 'Front'/'Rear'/'Side'/... elements properly, since they split up the
> > surround channels into seperate elements. Now, this is confusing in
> > many ways, even for "amixer" which will then show channels such as
> > "Rear Front Left" and so on, which obviously make no
> > sense. snd_mixer_selem_has_playback_channel() just returns bogus data
> > for these cases. Why are those elements seperate anyway? Why aren't
> > they combined into a single multi-channel event?
> 
> That's mainly a historical reason. In old days, there are no mixer
> apps supporting really multiple channels because the behavior of OSS.
> A stereo pair is easier to handle for apps.
> 
> > Looking at the APIs I
> > get the idea that the problem appears to be that elements can only
> > control all channels the same are all independantly which doesn't
> > really match 1:1 on my multichannel sound cards. However, wouldn't it
> > be possible to use the 'index' value of a selem_id for this? I.e. have
> > a series of controls by the same name but different indexes which
> > would then implement snd_mixer_selem_has_playback_channel() correctly?
> > i.e. foo,0 would do front-left/right, foo,1 would do rear, foo,2 would
> > do lfe, and so? I have no clue how this implemented internally, so not
> > sure how feasible this might be.
> 
> This breaks the existing apps. That's the biggest problem we face
> now. We can't change the stuff simply because PA isn't the only app
> using that API.
> 
> IMO, the best would be a total rewrite of the current mixer API, as I
> mentioned some times. Right now it's more complicated than needed,
> but not powerful enough to handle exceptional cases.
> 
> I know designing a generic and fully-working API is pretty difficult,
> though...
> 
> 
> thanks,
> 
> Takashi
> 
> 
> ------------------------------
> 
> Message: 6
> Date: Thu, 7 May 2009 15:05:08 +0530
> From: Arun KS <getarunks@gmail.com>
> Subject: Re: [alsa-devel] Beep sound in the end of audio file
> To: Mark Brown <broonie@sirena.org.uk>
> Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>,
> "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
> "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Peter
> Ujfalusi <peter.ujfalusi@nokia.com>
> Message-ID:
> <dfeb90390905070235i47f9aed4lbd2298ba07a5b989@mail.gmail.com>
> Content-Type: text/plain; charset=ISO-8859-1
> 
> On Wed, May 6, 2009 at 7:37 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> > On Wed, May 06, 2009 at 07:30:03PM +0530, Aggarwal, Anuj wrote:
> >
> >> > After a quick look I can not pin point the soc board file used with the
> >> > omap3evm board. Is it in the tree?
> >
> >> [Aggarwal, Anuj] No, it is not. Reason being we already have beagle &
> >> sdp3430 there, which are both similar to omap3evm, which I pushed.
> >> So mine got rejected. We had some discussions on how to handle this
> >> scenario but nothing got finalized.
> >
> > Not from the ALSA side it didn't...
> 
> Mark,
> 
> Since we are not going with the generic driver, are you going to push
> this patch:
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg07166.html
> 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at ?http://vger.kernel.org/majordomo-info.html
> >
> 
> 
> ------------------------------
> 
> Message: 7
> Date: Thu, 7 May 2009 10:38:02 +0100
> From: Mark Brown <broonie@sirena.org.uk>
> Subject: Re: [alsa-devel] Beep sound in the end of audio file
> To: Arun KS <getarunks@gmail.com>
> Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>,
> "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
> "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Peter
> Ujfalusi <peter.ujfalusi@nokia.com>
> Message-ID: <20090507093801.GA27897@sirena.org.uk>
> Content-Type: text/plain; charset=us-ascii
> 
> On Thu, May 07, 2009 at 03:05:08PM +0530, Arun KS wrote:
> 
> > Since we are not going with the generic driver, are you going to push
> > this patch:
> 
> > http://www.mail-archive.com/linux-omap@vger.kernel.org/msg07166.html
> 
> I can't see anything wrong with it looking in the web archive but somene
> should send a copy tested against current ASoC.
> 
> 
> ------------------------------
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 
> End of Alsa-devel Digest, Vol 27, Issue 23
> ******************************************
