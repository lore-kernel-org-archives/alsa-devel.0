From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Small memory leak in snd_pcm_ladspa_init()
Date: Thu, 22 Jul 2010 00:13:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007220013050.9258@eeebox2.perex-int.cz>
References: <4C4716D5.8080501@tds.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 554CA24436
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Jul 2010 00:13:59 +0200 (CEST)
In-Reply-To: <4C4716D5.8080501@tds.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Lindgren <john.lindgren@tds.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

n Wed, 21 Jul 2010, John Lindgren wrote:

> Hello,
>
> Valgrind shows up a small memory leak in libasound when using a LADSPA
> plugin.  Sorry, I don't have a patch this time.

Does this patch help?

diff --git a/src/pcm/pcm_ladspa.c b/src/pcm/pcm_ladspa.c
index 5161820..c413c10 100644
--- a/src/pcm/pcm_ladspa.c
+++ b/src/pcm/pcm_ladspa.c
@@ -341,6 +341,8 @@ static void snd_pcm_ladspa_free_instances(snd_pcm_t *pcm, snd_pcm_ladspa_t *lads
  						free(instance->output.m_data[idx]);
  					free(instance->output.m_data);
                                  }
+                                free(instance->input.data);
+                                free(instance->output.data);
  				list_del(&(instance->list));
  				snd_pcm_ladspa_free_eps(&instance->input);
  				snd_pcm_ladspa_free_eps(&instance->output);

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
