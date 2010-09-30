From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: alsactl adds volume controls?
Date: Thu, 30 Sep 2010 17:17:18 +0800
Message-ID: <AANLkTin2uZgheUT=UvnHU6amCto_yb6WXG6gq+Mczx=Y@mail.gmail.com>
References: <4C77CE1D.2070501@canonical.com> <4C77DD09.3060909@ladisch.de>
	<4C78059B.50801@canonical.com>
	<AANLkTi=cgE30nh1LPj84=Jv+YfJZWTj8BF3B5kNSGMTb@mail.gmail.com>
	<s5h4oec8r6f.wl%tiwai@suse.de> <4C7BABA9.1010100@canonical.com>
	<s5hlj7ont8e.wl%tiwai@suse.de> <4C7E549E.4080505@canonical.com>
	<s5hr5hczi06.wl%tiwai@suse.de> <4C7F6D5D.7020101@canonical.com>
	<alpine.LNX.2.00.1009021553460.10278@eeebox2.perex-int.cz>
	<4C7FB2CF.5060505@ladisch.de>
	<alpine.LNX.2.00.1009021721100.10278@eeebox2.perex-int.cz>
	<4C7FC85B.4000009@ladisch.de>
	<alpine.LNX.2.00.1009021926120.10278@eeebox2.perex-int.cz>
	<i7viav$kjb$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A7B2244D1
	for <alsa-devel@alsa-project.org>;
	Thu, 30 Sep 2010 11:17:18 +0200 (CEST)
Received: by eye27 with SMTP id 27so650621eye.38
	for <alsa-devel@alsa-project.org>; Thu, 30 Sep 2010 02:17:18 -0700 (PDT)
In-Reply-To: <i7viav$kjb$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/9/29 Colin Guthrie <gmane@colin.guthr.ie>

>
>
> From what I understand:
>  1. *All* HDA devices have a PCM softvol control. Some use this actively
> due to the fact they lack a real h/w volume control. Others do not
> technically "use" it.
>

If you disable pulseaudio in mandriva 2010  after a forced relogin by
mandrake center , it fall back to use dmix/dsnoop, so the softvol plugin
"PCM Playback Volume" and "Digital Capture Volume" are always used by any
application since they are defined in "default" device in HDA-Intel.conf
