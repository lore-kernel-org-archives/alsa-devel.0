From: "J. Scott Merritt" <alsauser@pragmasoft.com>
Subject: SALSA Lib 0.0.11 - pcm_drain
Date: Sun, 16 Sep 2007 19:01:32 -0400
Message-ID: <20070916190132.53daf48e.alsauser@pragmasoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.server.rpi.edu (smtp5.server.rpi.edu [128.113.2.225])
	by alsa0.perex.cz (Postfix) with ESMTP id CDF1724382
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Sep 2007 00:56:16 +0200 (CEST)
Received: from RPI02.localdomain (voiceflight.inc.rpi.edu [128.113.36.139])
	by smtp5.server.rpi.edu (8.13.1/8.13.1) with SMTP id l8GMuEZh000320
	for <alsa-devel@alsa-project.org>; Sun, 16 Sep 2007 18:56:15 -0400
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

In salsa-lib 0.0.11, pcm-macros.h : line 229

snd_pcm_drain calls the ioctl with SNDRV_PCM_IOCTL_DROP.
(seemingly confusing -drop- with -drain-)

Is there any reason that this shouldn't be changed to
call the ioctl with SNDRV_PCM_IOCTL_DRAIN ?

Thanks, Scott.
