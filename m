From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: how to mandate the use of PCM plugin?
Date: Tue, 28 Sep 2010 12:07:28 +0800
Message-ID: <AANLkTi=9gcs0A6s55wSS-RP4NucvUqkxCoYynezdF+5g@mail.gmail.com>
References: <4C9F6409.6010400@aknet.ru> <20100927005858.GD21247@sirena.org.uk>
	<4CA0221D.6030208@aknet.ru> <i7qltg$bph$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 25E2810387F
	for <alsa-devel@alsa-project.org>;
	Tue, 28 Sep 2010 06:07:29 +0200 (CEST)
Received: by eye27 with SMTP id 27so1647155eye.38
	for <alsa-devel@alsa-project.org>; Mon, 27 Sep 2010 21:07:28 -0700 (PDT)
In-Reply-To: <i7qltg$bph$1@dough.gmane.org>
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

2010/9/28 Colin Guthrie <gmane@colin.guthr.ie>

>
>
> And today, one of the Canonical guys published his version of a tool to
> help here:
> http://thread.gmane.org/gmane.comp.audio.pulseaudio.general/7542
>
> Hope this helps.
>
> Col
>
>
>
why did runtest.sh use a format  FLOAT64_LE which was not supported by PA ?

 ./runtest.sh pulse pulse
arecord: set_params:1055: Sample format non available
Available formats:
- U8
- S16_LE
- S16_BE
- S32_LE
- S32_BE
- FLOAT_LE
- FLOAT_BE
- MU_LAW
- A_LAW
Could not open file /tmp/dbtest.raw
