From: Kamil Wekalski <kaweka@gazeta.pl>
Subject: How does UCM's api integrate with ALSA legacy api?
Date: Wed, 7 May 2014 23:48:28 +0200
Message-ID: <99FB5EAB-0294-4400-9345-538AA8ADEBFF@gazeta.pl>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f48.google.com (mail-ee0-f48.google.com [74.125.83.48])
 by alsa0.perex.cz (Postfix) with ESMTP id D01A926532C
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 23:48:31 +0200 (CEST)
Received: by mail-ee0-f48.google.com with SMTP id e49so1127139eek.7
 for <alsa-devel@alsa-project.org>; Wed, 07 May 2014 14:48:31 -0700 (PDT)
Received: from pc01-b.fritz.box (e178221207.adsl.alicedsl.de. [85.178.221.207])
 by mx.google.com with ESMTPSA id 4sm6803985eef.44.2014.05.07.14.48.29
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 07 May 2014 14:48:30 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello All,

Please let me ask one question regarding one basic topic (I am newcomer in using ALSA 
in user space application).
The ALSA native api and thus the handshaking between ALSA and
its client seems to be based on stages as listed below. 
snd_pcm_open
snd_pcm_hw_params_alloca
snd_pcm_hw_params_any
snd_pcm_hw_params_set_...
snd_pcm_hw_params
snd_pcm_hw_params_get_...
snd_pcm_hw_params_is_...
snd_pcm_hw_params_can_...
snd_pcm_close

How the api of UCM integrate with ALSA-client handshaking?
Any document elaborating the topic in question available?
For any hints special thanks in advance.

kaweka 
