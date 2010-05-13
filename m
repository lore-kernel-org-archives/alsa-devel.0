From: "Andreas Falkenhahn" <andreas@airsoftsoftwair.de>
Subject: ALSA and Ubuntu
Date: Thu, 13 May 2010 20:39:42 +0200
Message-ID: <76bebf31719c3e262a9a4ee8c69f795c-EhVcX19FRQFfRwgeDBcNWRwwfgFLV15YQUBGAEFbWi9fXEYKW1loAFBWQ1peLkQAWFleR11cUAo=-webmailer2@server03.webmailer.hosteurope.de>
Reply-To: andreas@airsoftsoftwair.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from jordan.mc0.hosteurope.de (jordan.mc0.hosteurope.de
	[80.237.138.9]) by alsa0.perex.cz (Postfix) with ESMTP id C8D99243A3
	for <alsa-devel@alsa-project.org>;
	Thu, 13 May 2010 20:39:43 +0200 (CEST)
Received: from server03.webmailer.hosteurope.de ([10.9.0.182]);
	by mailout.hosteurope.de (jordan.mc0.hosteurope.de) running
	EXperimental Internet Mailer with esmtps (TLSv1:AES256-SHA:256)
	id 1OCdKL-0008Qo-BM
	for alsa-devel@alsa-project.org; Thu, 13 May 2010 20:40:09 +0200
Received: from nobody by server03.webmailer.hosteurope.de with local (Exim
	4.69) (envelope-from <andreas@airsoftsoftwair.de>)
	id 1OCdJu-0007Tq-OW
	for alsa-devel@alsa-project.org; Thu, 13 May 2010 20:39:42 +0200
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
List-Id: alsa-devel@alsa-project.org

Hi,

I just downloaded the latest Ubuntu Live CD (10.04) to try my app on it.
It is a plain X11 app using ALSA for sound output. I developed it on
openSUSE 11.2 and thought to give it a try on Ubuntu... that was a
mistake, because on Ubuntu, there seem to be lots of errors with ALSA.
Here are some observations:

1) snd_pcm_status_get_tstamp() always returns 0 for sec/usec.

2) snd_pcm_status_get_state() always returns SND_PCM_STATE_RUNNING, even
when the PCM stream has long reached a buffer underrun.

3) snd_pcm_delay()'s return value doesn't fall below ~7000 samples or so.
Even when the buffer has underrun, the return value is not 0 but about
~7000 samples. This makes it nearly impossible to detect when I should
start writing new samples to the buffer...

Could someone enlighten me what's going on there? Is this a known issue
with Ubuntu? I'm not using any weird addons or stuff. It's really just the
latest Ubuntu live CD. As I said, on openSUSE everything is working just
fine. But on Ubuntu, hell is really breaking loose here...

Thanks for help,

Andreas
