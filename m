From: Baek Chang <baeksan@ccrma.stanford.edu>
Subject: snd_pcm_avail_update() returning large values
Date: Thu, 5 May 2011 17:37:56 -0700
Message-ID: <BANLkTinbySDA6g40WcWYt-Yo0B-g6_B83w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51]) by alsa0.perex.cz (Postfix) with ESMTP id 6D1F32436D
	for <alsa-devel@alsa-project.org>;
	Fri,  6 May 2011 02:37:58 +0200 (CEST)
Received: by yib2 with SMTP id 2so1137954yib.38
	for <alsa-devel@alsa-project.org>; Thu, 05 May 2011 17:37:56 -0700 (PDT)
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

Occasionally, when using pulseaudio I see the following message:

snd_pcm_avail_update() returned a value that is exceptionally large.

This seems to be an issue with the ALSA driver itself.  My question is how
does snd_pcm_avail_update(), get updated? It uses hw buffer positions
correct?  Is there an example driver that implements snd_pcm_avail_update()
correctly and updates buffer positions correctly?

Thanks
Baek
