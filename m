From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: Re: [asoc:topic/topology 104/105] :undefined reference
 to `snd_soc_dapm_new_control'
Date: Thu, 04 Jun 2015 15:13:09 +0100
Message-ID: <1433427189.19747.53.camel@loki>
References: <201506041837.OFTVnhYj%fengguang.wu@intel.com>
 <20150604120418.GE14071@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 368F326061E
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 16:13:19 +0200 (CEST)
In-Reply-To: <20150604120418.GE14071@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2015-06-04 at 13:04 +0100, Mark Brown wrote:
> On Thu, Jun 04, 2015 at 06:58:38PM +0800, kbuild test robot wrote:
> 
> > All error/warnings (new ones prefixed by >>):
> > 
> >    sound/built-in.o: In function `soc_tplg_dapm_widget_create':
> > >> :(.text+0x25a90): undefined reference to `snd_soc_dapm_new_control'
> 
> The fix for the build bug in your patch exporting this was to add a
> static prototype (you were in the CC for that fix) so now the topology
> code still doesn't have the export.
> 
> Can you send a fixup please?

Sorry, appended below. I can resend separately if required.


>From 3df449a45fcde9f63dd34683d4216a73bd900f98 Mon Sep 17 00:00:00 2001
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Thu, 4 Jun 2015 15:08:34 +0100
Subject: [PATCH] ASoC: DAPM: fix build errors for missing
 snd_soc_dapm_new_control symbol

Fix the following error:-

All error/warnings (new ones prefixed by >>):
>
>    sound/built-in.o: In function `soc_tplg_dapm_widget_create':
> >> :(.text+0x25a90): undefined reference to `snd_soc_dapm_new_control'

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 sound/soc/soc-dapm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 92d57a9..1b4a6eb 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -53,7 +53,7 @@ static int snd_soc_dapm_add_path(struct snd_soc_dapm_context *dapm,
 	int (*connected)(struct snd_soc_dapm_widget *source,
 			 struct snd_soc_dapm_widget *sink));
 
-static struct snd_soc_dapm_widget *
+struct snd_soc_dapm_widget *
 snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 			 const struct snd_soc_dapm_widget *widget);
 
@@ -3270,7 +3270,7 @@ int snd_soc_dapm_put_pin_switch(struct snd_kcontrol *kcontrol,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dapm_put_pin_switch);
 
-static struct snd_soc_dapm_widget *
+struct snd_soc_dapm_widget *
 snd_soc_dapm_new_control(struct snd_soc_dapm_context *dapm,
 	const struct snd_soc_dapm_widget *widget)
 {
-- 
2.1.4
