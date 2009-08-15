From: Jon Smirl <jonsmirl@gmail.com>
Subject: SNDRV_PCM_TRIGGER_STOP and audio still queued in the
	driver
Date: Sat, 15 Aug 2009 11:06:08 -0400
Message-ID: <9e4733910908150806x38a395bev99f042a563d76edf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
	[209.85.211.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 75C7E24573
	for <alsa-devel@alsa-project.org>;
	Sat, 15 Aug 2009 17:06:09 +0200 (CEST)
Received: by ywh11 with SMTP id 11so3021462ywh.16
	for <alsa-devel@alsa-project.org>; Sat, 15 Aug 2009 08:06:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

In the mpc5200 driver I'm receiving SNDRV_PCM_TRIGGER_STOP with audio
still queued. I noticed this in an app that uses a 2MB ALSA buffer. It
is filling the 2MB buffer which starts playing. After the buffer is
filled I receive the STOP. This STOP comes before the hardware has a
chance to play all of the music. There is still about twenty seconds
of music in the driver buffer waiting to be played.

How is this supposed to work?

-- 
Jon Smirl
jonsmirl@gmail.com
