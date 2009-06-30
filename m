From: Paul Fertser <fercerpav@gmail.com>
Subject: Re: External PCM hook SO is dlclosed after
	calling	install, making it hard to have hooks in it
Date: Tue, 30 Jun 2009 15:24:51 +0400
Message-ID: <20090630112451.GG23025@home.pavel.comp>
References: <20090629221101.GD23025@home.pavel.comp>
	<s5hd48mi76e.wl%tiwai@suse.de>
	<20090630062054.GE23025@home.pavel.comp>
	<s5hab3qi638.wl%tiwai@suse.de>
	<20090630063804.GF23025@home.pavel.comp>
	<s5h4oty9ivw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="IMjqdzrDRly81ofr"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f226.google.com (mail-fx0-f226.google.com
	[209.85.220.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 934D824A12
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Jun 2009 13:25:44 +0200 (CEST)
Received: by fxm26 with SMTP id 26so63662fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2009 04:25:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5h4oty9ivw.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Joerg Reisenweber <joerg@openmoko.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2009 at 11:21:39AM +0200, Takashi Iwai wrote:
> Paul Fertser wrote:
> > TBH, i've not tried but i'm pretty sure it will fix the problem. I
> > tried with dlopen workaround (to increase the refcounter) in install
> > function and i tried with LD_PRELOAD'ing the library before starting
> > an alsa app; both workarounds worked.
> 
> OK, I fixed this on GIT now.

Wow! Thanks a lot for this fast and proper fix! I compile-tested it,
will try running later, but it should be ok. :)

While reading the diff i saw you introduced several unused variables,
patch attached.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com

--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="0001-pcm_hooks-cosmetic-removal-of-unused-variables.patch"

>From 3847baf57561871f09c7be48b10f3058feb117ee Mon Sep 17 00:00:00 2001
From: Paul Fertser <fercerpav@gmail.com>
Date: Tue, 30 Jun 2009 15:18:36 +0400
Subject: [PATCH] pcm_hooks: cosmetic removal of unused variables


Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---
 src/pcm/pcm_hooks.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/src/pcm/pcm_hooks.c b/src/pcm/pcm_hooks.c
index 2fbee73..3a99d55 100644
--- a/src/pcm/pcm_hooks.c
+++ b/src/pcm/pcm_hooks.c
@@ -99,7 +99,6 @@ static int snd_pcm_hooks_close(snd_pcm_t *pcm)
 		}
 	}
 	while (!list_empty(&h->dllist)) {
-		struct snd_pcm_hook_dllist *dl;
 		pos = h->dllist.next;
 		hook_remove_dlobj(list_entry(pos, struct snd_pcm_hook_dllist, list));
 	}
@@ -345,7 +344,6 @@ static int snd_pcm_hook_add_conf(snd_pcm_t *pcm, snd_config_t *root, snd_config_
 	snd_config_iterator_t i, next;
 	int (*install_func)(snd_pcm_t *pcm, snd_config_t *args) = NULL;
 	void *h = NULL;
-	struct snd_pcm_hook_dllist *dl;
 
 	if (snd_config_get_type(conf) != SND_CONFIG_TYPE_COMPOUND) {
 		SNDERR("Invalid hook definition");
-- 
1.6.1.3


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--IMjqdzrDRly81ofr--
