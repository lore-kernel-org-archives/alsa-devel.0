From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: hda-intel front headphone (8086:27d8 1043:83bc)
Date: Sat, 9 Jul 2011 15:30:07 +0800
Message-ID: <CAN8cciZG=Cx8_9W7DNtCgde9Xy9h=ZBA0cXh1sni6VQhy-veeg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50]) by alsa0.perex.cz (Postfix) with ESMTP id 5FD712449B
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 15:21:06 +0200 (CEST)
Received: by fxh2 with SMTP id 2so4252210fxh.9
	for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2011 06:21:06 -0700 (PDT)
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

> My knowledge of audio/alsa programming is really poor, but if someone suggest
> a patch I can setup the thing and do some debug.

Try Takashi 's daily snapshot tarball

you should able to get "Headphone Playback Volume" after this patch
"ALSA: hda - Code consolidation for ALC88x and ALC662 auto-parsers"

using hda-emu and it seem the driver support 6 channels even when the
pink and blue jacks are not retasked
