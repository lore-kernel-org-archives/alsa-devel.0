From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: [PATCH 0/2] ASoC: TWL4030: DAPM restructuring	and
 Headset pop-attenuation fix
Date: Tue, 19 May 2009 14:00:50 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03056A16C9@dbde02.ent.ti.com>
References: <1242651725-15001-1-git-send-email-peter.ujfalusi@nokia.com>
	<2C7D3DF36ADFFC479B44490D912B616705F69E87E2@dlee07.ent.ti.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB03056A164D@dbde02.ent.ti.com>
	<200905191100.29541.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 103982467C
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 10:31:01 +0200 (CEST)
In-Reply-To: <200905191100.29541.peter.ujfalusi@nokia.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "getarunks@gmail.com" <getarunks@gmail.com>, "Lopez Cruz,
	Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Peter Ujfalusi [mailto:peter.ujfalusi@nokia.com]
> Sent: Tuesday, May 19, 2009 1:30 PM
> To: Aggarwal, Anuj
> Cc: Mark Brown; sakoman@gmail.com; alsa-devel@alsa-project.org;
> getarunks@gmail.com; Lopez Cruz, Misael
> Subject: Re: [alsa-devel] [PATCH 0/2] ASoC: TWL4030: DAPM restructuring
> and Headset pop-attenuation fix
> =

> On Tuesday 19 May 2009 09:47:13 ext Aggarwal, Anuj wrote:
> > I am facing problems on the capture side now, I don't know whether
> someone
> > has tested it or not.
> >
> > By default, capture was not working. I have to enable Analog Left Captu=
re
> > Route AUXL & Analog Right Capture Route AUXR to enable the capture
> > paths for OMAP3 EVM. Even after enabling both the paths, I am not able =
to
> > capture audio on both the channels. I am hearing audio only on either of
> > the channel, the other one is playing only noise for me. (This channel
> > swapping is random, sometimes it plays on left and sometimes on right.)
> >
> > If I disable ' Analog Right Capture Route AUXR', I am not hearing any
> > noise; audio is playing fine, but again on either of the channels, not
> > consistently on the left one.
> >
> > Moreover, in both the cases, I am getting large overrun errors (I am us=
ing
> > NFS to store the recorded clips, will try with MMC etc. too):
> >
> > root:~# arecord -f cd -d 30 rec05.dat
> > Recording WAVE 'rec05.dat' : Signed 16 bit Little Endian, Rate 44100 Hz,
> > Stereo overrun!!! (at least 8424.774 ms long)
> > overrun!!! (at least 6465.943 ms long)
> > overrun!!! (at least 3377.716 ms long)
> > overrun!!! (at least 7982.147 ms long)
> > overrun!!! (at least 8649.720 ms long)
> >
> > I didn't face both the problems on my original code base (2.6.29-rc3) a=
nd
> > hence wanted to confirm whether someone else has also faced the same
> > issues. I am debugging at my end to see what difference is causing the
> > problem but any pointers are welcome.
> =

> I have sent a patch, which should get the AUXR working again.
[Aggarwal, Anuj] Yeah, it is working fine now. Thanks for this.
I am still getting underrun errors, looking into this now.
> =

> >
> > Thanks and Regards,
> > Anuj Aggarwal
> >
> --
> P=E9ter
