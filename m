From: "Munzir Taha (=?utf-8?q?=D9=85=D9=86=D8=B0=D8=B1?=
	=?utf-8?q?_=D8=B7=D9=87?=)" <munzirtaha@gmail.com>
Subject: Re: My Codec: IDT 92HD75B3X5 issues
Date: Tue, 29 Sep 2009 22:50:34 +0300
Message-ID: <200909292250.34870.munzirtaha@gmail.com>
References: <200909280658.46580.munzirtaha@gmail.com>
	<200909291624.29900.munzirtaha@gmail.com>
	<s5hr5tp4y27.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f212.google.com (mail-fx0-f212.google.com
	[209.85.220.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 99DAB10380C
	for <alsa-devel@alsa-project.org>;
	Tue, 29 Sep 2009 21:50:41 +0200 (CEST)
Received: by fxm8 with SMTP id 8so3853666fxm.45
	for <alsa-devel@alsa-project.org>; Tue, 29 Sep 2009 12:50:40 -0700 (PDT)
In-Reply-To: <s5hr5tp4y27.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Yau al-Thulatha 09 Shawwal 1430 5:37:04 pm you wrote:
> At Tue, 29 Sep 2009 16:24:29 +0300,
> 
>  Munzir Taha (=?utf-8?q?=D9=85=D9=86=D8=B0=D8=B1?=   
=?utf-8?q?_=D8=B7=D9=87?=) wrote:
> > On Yau al-Thulatha 09 Shawwal 1430 9:24:19 am Takashi Iwai wrote:
> > > At Tue, 29 Sep 2009 07:40:56 +0300,
> > >
> > >  Munzir Taha (=?utf-8?q?=D9=85=D9=86=D8=B0=D8=B1?=
> >
> > =?utf-8?q?_=D8=B7=D9=87?=) wrote:
> > > > On Yaum al-Ithnain 08 Shawwal 1430 11:41:52 am Takashi Iwai wrote:
> > > > > At Mon, 28 Sep 2009 06:58:46 +0300,
> > > > >
> > > > >  Munzir Taha (=?utf-8?q?=D9=85=D9=86=D8=B0=D8=B1?=
> > > >
> > > > =?utf-8?q?_=D8=B7=D9=87?=) wrote:
> > > > > > Hi sirs,
> > > > > > These are the issues I have with my Laptop HP Pavilion dv6 1225ee
> > > > > > regarding audio support.
> > > > > >
> > > > > > 1. No sense for headphone jack (jack_present?), when headphone is
> > > > > > plugged (present_int_hp?)
> > > > > >
> > > > > > 2. There headphone mic jack is not working. The one next to the
> > > > > > webcam is always recording even when I change the "Mic Jack"
> > > > > > control from "Mic In" to "Line In"
> > > > >
> > > > > Make sure that you use alsa-driver-snapshot tarball instead of
> > > > > 1.0.21 released version.  There are many fixes since 1.0.21
> > > > > release.
> > > > >
> > > > >
> > > > >
> > > > > ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-dr
> > > > >iver -sn apshot.tar.gz
> > > >
> > > > Thanks a lot Takashi, things are better now. However, when I tested
> > > > the internal mic it's very noisy. I played a bit with the capture and
> > > > digital controls but still compared with Windows, it's lame.
> > >
> > > OK, could you give alsa-info.sh output at this state?
> > > Please run with --no-upload option, and attach the generated file.
> >
> > Attached.
> 
> Try to run:
> 
>    % amixer -c0 set Capture cap 12dB
>    % amixer -c0 set "Digital Mic" 10dB
>    % amixer -c0 set Digital 0dB
> 
> Any difference?

No, still there is a clear shshshshshsh sound in the background

-- 
Munzir Taha
Telecommunications and Electronics Engineer
Master CIW Designer, ICDL, MOUS, Linux+, LPI, SCSA
Riyadh, SA
