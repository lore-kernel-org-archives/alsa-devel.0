From: VDR User <user.vdr@gmail.com>
Subject: snd-hda-codec-hdmi option static_hdmi_pcm=1 causes
	glitchy audio
Date: Sun, 12 Nov 2017 15:33:59 -0800
Message-ID: <CAA7C2qj4QWDHcH8U7AGCiN77Pe-Bn2jGDAvNBphNLMp8j-XSzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f52.google.com (mail-lf0-f52.google.com
 [209.85.215.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 853BF266A73
 for <alsa-devel@alsa-project.org>; Mon, 13 Nov 2017 00:34:01 +0100 (CET)
Received: by mail-lf0-f52.google.com with SMTP id g35so2103356lfi.13
 for <alsa-devel@alsa-project.org>; Sun, 12 Nov 2017 15:34:01 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "mailing list: alsa-dev" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi. I was checking my surround sound setup with speaker-test and
noticed that setting static_hdmi_pcm=1 for snd-hda-codec-hdmi causes
audio to sound glitchy. Not sure what's going on there but thought I
should report it.

I'm using an Nvidia GT520 video card with audio/video being sent to my
surround receiver via HDMI. Kernel 4.13.12, Debian Testing, nvidia
driver 375.82

Thanks
