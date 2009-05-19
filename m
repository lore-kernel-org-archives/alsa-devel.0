From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: Re: [PATCH 0/2] ASoC: TWL4030: DAPM
	restructuring	and	Headset pop-attenuation fix
Date: Tue, 19 May 2009 12:17:13 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB03056A164D@dbde02.ent.ti.com>
References: <1242651725-15001-1-git-send-email-peter.ujfalusi@nokia.com>
	<20090518130928.GD1629@sirena.org.uk>
	<5A47E75E594F054BAF48C5E4FC4B92AB03056A148C@dbde02.ent.ti.com>
	<2C7D3DF36ADFFC479B44490D912B616705F69E87E2@dlee07.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
	by alsa0.perex.cz (Postfix) with ESMTP id D88132464A
	for <alsa-devel@alsa-project.org>;
	Tue, 19 May 2009 08:47:26 +0200 (CEST)
In-Reply-To: <2C7D3DF36ADFFC479B44490D912B616705F69E87E2@dlee07.ent.ti.com>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "sakoman@gmail.com" <sakoman@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "getarunks@gmail.com" <getarunks@gmail.com>, "Lopez Cruz,
	Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

I am facing problems on the capture side now, I don't know whether someone has tested it or not.

By default, capture was not working. I have to enable Analog Left Capture 
Route AUXL & Analog Right Capture Route AUXR to enable the capture 
paths for OMAP3 EVM. Even after enabling both the paths, I am not able to
capture audio on both the channels. I am hearing audio only on either of the
channel, the other one is playing only noise for me. (This channel swapping is 
random, sometimes it plays on left and sometimes on right.)

If I disable ' Analog Right Capture Route AUXR', I am not hearing any noise;
audio is playing fine, but again on either of the channels, not consistently on
the left one.

Moreover, in both the cases, I am getting large overrun errors (I am using 
NFS to store the recorded clips, will try with MMC etc. too): 
 
root:~# arecord -f cd -d 30 rec05.dat
Recording WAVE 'rec05.dat' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
overrun!!! (at least 8424.774 ms long)
overrun!!! (at least 6465.943 ms long)
overrun!!! (at least 3377.716 ms long)
overrun!!! (at least 7982.147 ms long)
overrun!!! (at least 8649.720 ms long)

I didn't face both the problems on my original code base (2.6.29-rc3) and hence
wanted to confirm whether someone else has also faced the same issues. I am
debugging at my end to see what difference is causing the problem but any 
pointers are welcome.

Thanks and Regards,
Anuj Aggarwal

> -----Original Message-----
> From: Lopez Cruz, Misael
> Sent: Tuesday, May 19, 2009 6:18 AM
> To: Aggarwal, Anuj; Mark Brown; Peter Ujfalusi
> Cc: sakoman@gmail.com; alsa-devel@alsa-project.org; getarunks@gmail.com
> Subject: RE: [alsa-devel] [PATCH 0/2] ASoC: TWL4030: DAPM restructuring
> and Headset pop-attenuation fix
> 
> > > > The following series aims to fix the Headset power on/off
> > > > pop noise problems.
> 
> > > Looks OK but given all the to and fro here I'd rather wait for some
> > > testing to make sure it works well on other system.s
> 
> > [Aggarwal, Anuj] I tried this on OMAP3 EVM. Ramp delay values
> > 0-3 produces minor glitches in the beginning & end, value 4
> > gave me the best result so far on my EVM, I will try with
> > some other EVMs as well before finalizing it. 5 and others
> > produce a beep in the beginning and end.
> > Just one question, is there any side-effect of choosing a
> > large ramp delay? For e.g. in my case, it could be 437ms
> > (19.2MHz clock).
> 
> I tested on SDP3430, the best ramp delay value for my board seems to
> be 3. Lower values give glitches and higher values present the beep
> sound. In general, it has been reduced.
> 
> -Misa
