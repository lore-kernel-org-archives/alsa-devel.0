From: Joonyoung Shim <dofmind@gmail.com>
Subject: [PATCH 0/1] ASoC: twl4030 - Fix build error
Date: Mon, 16 Mar 2009 12:07:52 +0900
Message-ID: <4e1455be0903152007h73b99fd8n411d64880be4242f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.172])
	by alsa0.perex.cz (Postfix) with ESMTP id AC8461037FB
	for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2009 04:07:53 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 26so1491999wfd.23
	for <alsa-devel@alsa-project.org>; Sun, 15 Mar 2009 20:07:52 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I found twl4030 build error.
It appears because of changes of following commit:
    ASoC: make ops a pointer in 'struct snd_soc_dai'

---
Joonyoung Shim (1):
 ASoC: twl4030 - Fix build error

 sound/soc/codecs/twl4030.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

-- 
- Joonyoung Shim
