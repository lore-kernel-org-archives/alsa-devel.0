From: arif setiawan <n.arif.setiawan@gmail.com>
Subject: get two mono channel from stereo line
Date: Mon, 27 Jul 2009 15:54:30 +0700
Message-ID: <c697747b0907270154p262dda6eg9db1968c7c583a2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yx0-f177.google.com (mail-yx0-f177.google.com
	[209.85.210.177])
	by alsa0.perex.cz (Postfix) with ESMTP id AE5742415D
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Jul 2009 10:54:32 +0200 (CEST)
Received: by yxe7 with SMTP id 7so5179412yxe.16
	for <alsa-devel@alsa-project.org>; Mon, 27 Jul 2009 01:54:31 -0700 (PDT)
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

Thank you.
It works as we expected, however we found that we can't run two lines
(left-capture - left-playback) and (right-capture - right-playback)
simulatenously.

The error message is :
ALSA lib pcm_dshare.c:706:(snd_pcm_dshare_open) unable to open slave
cannot open output audio device right: Device or resource busy

Is there any workaround for this?
