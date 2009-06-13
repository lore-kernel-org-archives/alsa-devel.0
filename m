From: Karthik Ramgopal <applefreakpeeps@gmail.com>
Subject: Request for Device ID addition : 6935G
Date: Sat, 13 Jun 2009 10:24:45 +0800
Message-ID: <4b8c423b0906121924u757d590ay49e09f3fea3c99e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f175.google.com (mail-px0-f175.google.com
	[209.85.216.175])
	by alsa0.perex.cz (Postfix) with ESMTP id B0D9B244EE
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Jun 2009 04:24:46 +0200 (CEST)
Received: by pxi5 with SMTP id 5so867412pxi.16
	for <alsa-devel@alsa-project.org>; Fri, 12 Jun 2009 19:24:45 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
       Acer Aspire 6935G sound system is confirmed to be functional
with model=acer-aspire-8930g. Kindly add device ID 0x1025 0x0146 to
the quirks list in patch_realtek.c . Jack detetction and playback is
working without any hda-verbing. Just the internal mic seems to be a
problem. Can't hear my voice, can just hear static when I playback a
recording. Anyways big thanks to Hector and Takashi for getting it all
to work.

Regards,
Karthik
