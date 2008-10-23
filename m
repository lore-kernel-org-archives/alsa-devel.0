From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: Problem setting mixer switch with amixer/alsactl.
Date: Thu, 23 Oct 2008 19:45:20 +0200
Message-ID: <87mygvmci7.fsf@free.fr>
References: <48FF7538.3090000@oliford.co.uk>
	<20081023132705.GA20557@sirena.org.uk>
	<4900829A.8000703@oliford.co.uk>
	<20081023140116.GB17901@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp8-g19.free.fr (smtp8-g19.free.fr [212.27.42.65])
	by alsa0.perex.cz (Postfix) with ESMTP id 3224B103880
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 19:45:43 +0200 (CEST)
In-Reply-To: <20081023140116.GB17901@sirena.org.uk> (Mark Brown's message of
	"Thu\, 23 Oct 2008 15\:01\:17 +0100")
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
Cc: alsa-devel@alsa-project.org, Oliver Ford <ipaqlinux@oliford.co.uk>
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@sirena.org.uk> writes:

> On Thu, Oct 23, 2008 at 02:56:42PM +0100, Oliver Ford wrote:
>
>> The offending mixer switch has the truncated text name 'Speaker Mixer 
>> PCM Playback Swit' under amixer but it obviously is supposed to be 
>> 'Switch' on  the end. I don't know if that might somehow cause problems?
>
> This is normal - shouldn't be an issue except in UI terms, ALSA limits
> the length of names.

Mark, I don't think that's true.
I had that problem several monthes ago (remember my patch about alsa controls
length ?).

Do you remember that patch, which went into asoc-v2 ? :

--
Robert


>From a1b99c3bcef6bf4773e9b43335fe1f91424674c6 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <rjarzmik@free.fr>
Date: Sun, 16 Mar 2008 22:48:17 +0100
Subject: [PATCH] Correct dapm controls length.

Dapm control names should follow alsa standard, which
defines controls name's length to 44 and not 32.

Signed-off-by: Robert Jarzmik <rjarzmik@free.fr>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-dapm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 4b03e3f..a61024c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -281,7 +281,7 @@ static int dapm_new_mixer(struct snd_soc_card *soc_card,
 	struct snd_soc_dapm_widget *w)
 {
 	int i, ret = 0;
-	char name[32];
+	char name[44];
 	struct snd_soc_dapm_path *path;
 
 	/* add kcontrol */
@@ -295,7 +295,7 @@ static int dapm_new_mixer(struct snd_soc_card *soc_card,
 				continue;
 
 			/* add dapm control with long name */
-			snprintf(name, 32, "%s %s", w->name, w->kcontrols[i].name);
+			snprintf(name, 44, "%s %s", w->name, w->kcontrols[i].name);
 			path->long_name = kstrdup (name, GFP_KERNEL);
 			if (path->long_name == NULL)
 				return -ENOMEM;
-- 
1.5.6.5
