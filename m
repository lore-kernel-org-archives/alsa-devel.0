From: Adam Rosenberg <adam@alcorn.com>
Subject: Modifying the AD193X driver and integrating with the
	Blackfin platform
Date: Sun, 27 Jun 2010 09:34:16 -0400
Message-ID: <AANLkTimmzCY6rTrrV7aCBgznfekeIQxwY8kUDUGLDY_9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 51BA5103891
	for <alsa-devel@alsa-project.org>;
	Sun, 27 Jun 2010 15:34:20 +0200 (CEST)
Received: by vws11 with SMTP id 11so2242422vws.38
	for <alsa-devel@alsa-project.org>; Sun, 27 Jun 2010 06:34:17 -0700 (PDT)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

I see that Liam just modified the code (bf5xx-ad193x.c) that I was
looking at modifying to add support for the CS42448 CODEC.=A0 I would
like to understand the architecture of the ASoC and Blackfin TDM PCM
driver that it uses because I need to enable the secondary data lines
to support multiple chips.=A0 Where can I find the documentation for
this code?

If I want to integrate this code into the uClinux-dist-2009R1.1-RC4
distribution, is it simply a matter of copying the files in
"[linux-2.6-asoc.git]/sound/" to the linux-2.6/sound directory for
uClinux?=A0 Or is it better if I git clone linux-2.6-asoc and move my
custom board development files there?=A0 Is there a driver installation
guide somewhere that I can read about this?

I am concerned that the official Blackfin distribution
(http://blackfin.uclinux.org/gf/download/frsrelease/473/7285/uClinux-dist-2=
009R1.1-RC4.tar.bz2)
will not be compatible with the ASoC distribution
(git://opensource.wolfsonmicro.com/linux-2.6-asoc).=A0 Can you tell me
if there are any differences between these?

To sum up:
1.  Where can I find the ASoC documentation?
2.  Is there an installation guide to use ASoC with an existing Kernel?
3.  What are the differences between the wolfsonmicro.com
linux-2.6-asoc and blackfin.uclinux.org uClinux-dist-2009R1.1-RC4?

Thank you,
Adam

Adam Rosenberg
Software Engineer

Alcorn McBride Inc.
3300 South Hiawassee
Building 105
Orlando, FL 32835

(407) 296 - 5800 ext. 5490
