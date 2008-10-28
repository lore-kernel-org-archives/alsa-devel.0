From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problem setting mixer switch with amixer/alsactl.
Date: Tue, 28 Oct 2008 13:10:31 +0000
Message-ID: <20081028131031.GG9068@sirena.org.uk>
References: <48FF7538.3090000@oliford.co.uk>
	<20081023132705.GA20557@sirena.org.uk>
	<4900829A.8000703@oliford.co.uk>
	<20081023140116.GB17901@sirena.org.uk> <87mygvmci7.fsf@free.fr>
	<20081024172533.GA3328@sirena.org.uk> <87ej25ero2.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CD26924450
	for <alsa-devel@alsa-project.org>; Tue, 28 Oct 2008 14:10:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87ej25ero2.fsf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, Oliver Ford <ipaqlinux@oliford.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 24, 2008 at 09:09:33PM +0200, Robert Jarzmik wrote:
> Mark Brown <broonie@sirena.org.uk> writes:

> > All this patch does is change the limit, there is still a limit on the
> > length of control names in ALSA but as I say it's purely a cosmetic issue.

> I don't quite agree on the "cosmetic".

> If I recall correctly, that name is used in dapm path setup. If the name is
> incorrect (truncated), some dapm elements are not switched on. I'm speaking from
> memory, I'll try to browse my git repository to track it back. Notice that I'm
> really busy ATM, so I don't have enough manpower to test immediatly.

It looks like you might've been right after all.  I still can't see
where this makes a difference to the speaker paths but the patch below
seems to resolve the issues I'm seeing here.

Oliver, could you test the patch below please?

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 28da235..fdb4d2c 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -293,7 +293,7 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 	struct snd_soc_dapm_widget *w)
 {
 	int i, ret = 0;
-	char name[32];
+	size_t name_len;
 	struct snd_soc_dapm_path *path;
 
 	/* add kcontrol */
@@ -307,11 +307,16 @@ static int dapm_new_mixer(struct snd_soc_codec *codec,
 				continue;
 
 			/* add dapm control with long name */
-			snprintf(name, 32, "%s %s", w->name, w->kcontrols[i].name);
-			path->long_name = kstrdup (name, GFP_KERNEL);
+			name_len = 2 + strlen(w->name)
+				+ strlen(w->kcontrols[i].name);
+			path->long_name = kmalloc(name_len, GFP_KERNEL);
 			if (path->long_name == NULL)
 				return -ENOMEM;
 
+			snprintf(path->long_name, name_len, "%s %s",
+				 w->name, w->kcontrols[i].name);
+			path->long_name[name_len - 1] = '\0';
+
 			path->kcontrol = snd_soc_cnew(&w->kcontrols[i], w,
 				path->long_name);
 			ret = snd_ctl_add(codec->card, path->kcontrol);
