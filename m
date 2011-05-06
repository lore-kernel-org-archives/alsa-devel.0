From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Disable Sticky PCM stream assignment for AD codecs
Date: Fri, 6 May 2011 14:29:53 +0800
Message-ID: <BANLkTi=Wei7NBL=rkb=yPNR_QFp4ZUCW=Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FC2F103839
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 08:29:54 +0200 (CEST)
Received: by fxm5 with SMTP id 5so2325427fxm.38
	for <alsa-devel@alsa-project.org>; Thu, 05 May 2011 23:29:53 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Refer to 0e7adbe263f89ea2ef15b5af5e80a812b2a85025
"Disable sticky PCM stream assignment for AD codecs"

Is it normal for  "hda_codec_cleanup_stream" appear twice in system log when
stick PCM stream is disabled

arecord -v -Dhw:CARD=Intel -f cd  /dev/null

ALSA hda_intel.c:1678: azx_pcm_prepare: bufsize=0x10000, format=0x4011
ALSA hda_codec.c:1295: hda_codec_setup_stream: NID=0x8, stream=0x1,
channel=0, format=0x4011
ALSA hda_codec.c:1358: hda_codec_cleanup_stream: NID=0x8
ALSA hda_codec.c:1358: hda_codec_cleanup_stream: NID=0x8
