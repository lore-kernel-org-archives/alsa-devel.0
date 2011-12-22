From: Appalayagari Sreedhar <sreecha01@gmail.com>
Subject: pcm timer resolution out of range (rate = 0,
 period_size = 1), Division by zero in kernel
Date: Thu, 22 Dec 2011 12:58:23 +0530
Message-ID: <CAODvfaGXziDeSAic-Rg_dBJYWeObgcQhmcy4=vNBL30Mc6GQQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 947CD103C81
	for <alsa-devel@alsa-project.org>; Thu, 22 Dec 2011 08:28:25 +0100 (CET)
Received: by yhjj56 with SMTP id j56so5693568yhj.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 23:28:23 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

We are working with 2.6.32 kernel. we are working with ALSA model
codec driver for conexant chipset. we are using OSS emulation for
audio playback and recording.

we are not setting the fragmenttaion block using OSS ioctl function
(SNDCTL_DSP_SETFRAGMENT) , assuming that it will be taken care by the
ALSA framework based on the sampling rate, bits per sample etc.

we are facing the below issue randomly.

ALSA sound/core/pcm_timer.c:71: -calling VIDIOC_pcm timer resolution
out of range (rate = 0, period_size = 1)
Division by zero in kernel.

We tried to program the fragmentation block after the sampling rate,
bits per sample etc are configured. it is working fine for 5 or 6
iterations for recording and playback.

after that the audio quality is gone bad. the audio is not smooth and
it is sharp.

could you please help to resolve this problem.

Thank you,
Sreedhar.
