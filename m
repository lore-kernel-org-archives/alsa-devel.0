From: John Lindgren <john.lindgren@tds.net>
Subject: Small memory leak in snd_pcm_ladspa_init()
Date: Wed, 21 Jul 2010 11:48:37 -0400
Message-ID: <4C4716D5.8080501@tds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f172.google.com (mail-qy0-f172.google.com
	[209.85.216.172])
	by alsa0.perex.cz (Postfix) with ESMTP id E2F6A243EF
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 17:48:43 +0200 (CEST)
Received: by qyk1 with SMTP id 1so3173526qyk.17
	for <alsa-devel@alsa-project.org>; Wed, 21 Jul 2010 08:48:42 -0700 (PDT)
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

Hello,

Valgrind shows up a small memory leak in libasound when using a LADSPA
plugin.  Sorry, I don't have a patch this time.

==30783== 16 bytes in 2 blocks are definitely lost in loss record 1,976 of 6,954
==30783==    at 0x4C2380C: calloc (vg_replace_malloc.c:467)
==30783==    by 0x1B06BEFD: snd_pcm_ladspa_init (pcm_ladspa.c:744)
==30783==    by 0x1B04B325: snd_pcm_plugin_prepare (pcm_plugin.c:167)
==30783==    by 0x1B04B2EE: snd_pcm_plugin_prepare (pcm_plugin.c:158)

==30783== 16 bytes in 2 blocks are definitely lost in loss record 1,977 of 6,954
==30783==    at 0x4C2380C: calloc (vg_replace_malloc.c:467)
==30783==    by 0x1B06BF25: snd_pcm_ladspa_init (pcm_ladspa.c:746)
==30783==    by 0x1B04B325: snd_pcm_plugin_prepare (pcm_plugin.c:167)
==30783==    by 0x1B04B2EE: snd_pcm_plugin_prepare (pcm_plugin.c:158)

...

==30783== 16 bytes in 2 blocks are definitely lost in loss record 1,980 of 6,954
==30783==    at 0x4C2380C: calloc (vg_replace_malloc.c:467)
==30783==    by 0x1B06BEFD: snd_pcm_ladspa_init (pcm_ladspa.c:744)
==30783==    by 0x1B04B325: snd_pcm_plugin_prepare (pcm_plugin.c:167)
==30783==    by 0x1B04B2EE: snd_pcm_plugin_prepare (pcm_plugin.c:158)
==30783==    by 0x1B03B2DC: snd_pcm_recover (pcm.c:7246)

==30783== 16 bytes in 2 blocks are definitely lost in loss record 1,981 of 6,954
==30783==    at 0x4C2380C: calloc (vg_replace_malloc.c:467)
==30783==    by 0x1B06BF25: snd_pcm_ladspa_init (pcm_ladspa.c:746)
==30783==    by 0x1B04B325: snd_pcm_plugin_prepare (pcm_plugin.c:167)
==30783==    by 0x1B04B2EE: snd_pcm_plugin_prepare (pcm_plugin.c:158)
==30783==    by 0x1B03B2DC: snd_pcm_recover (pcm.c:7246)

... and so on.

-- John
