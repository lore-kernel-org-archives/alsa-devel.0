From: Shine Liu <shinel@foxmail.com>
Subject: Re: [PATCH] pcm_lib.c: Fixed inaccurate calculation of
 hw_ptr_interrupt in snd_pcm_update_hw_ptr_interrupt function
Date: Thu, 20 Aug 2009 15:20:42 +0800
Message-ID: <1250752842.5644.34.camel@shinel>
References: <1250677339.3516.17.camel@shinel> <s5hd46scctf.wl%tiwai@suse.de>
	<1250679571.500.20.camel@shinel> <s5h7hx0c8l2.wl%tiwai@suse.de>
	<1250686106.2060.16.camel@sl>  <s5hocqcarrx.wl%tiwai@suse.de>
Reply-To: shinel@foxmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpbg67.qq.com (smtpbg67.qq.com [119.147.10.226])
	by alsa0.perex.cz (Postfix) with SMTP id 6C63C24426
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Aug 2009 09:21:25 +0200 (CEST)
In-Reply-To: <s5hocqcarrx.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2009-08-19 at 14:53 +0200, Takashi Iwai wrote:
> At Wed, 19 Aug 2009 12:48:26 +0000,
> Shine Liu wrote:
> > 
> > On Wed, 2009-08-19 at 14:05 +0200, Takashi Iwai wrote:
> > > > 
> > > > But the irq last issued should be at 0x3e80, but not 0x3800 + 0x800 =
> > > > 0x4000. The DMA engine loaded 0x680 frame not 0x800 frame at the last
> > > > time.
> > > 
> > > Then it's a driver bug.  If unaligned period size is allowed, it means
> > > that the irq is really generated in that period, not at the buffer
> > > boundary.  Otherwise, it must have a proper hw-constraint to align the
> > > period size to the buffer size.

Hi, Takashi

    I carefully read the pcm_lib.c and pcm_native.c but I didn't found
any alignmnet constraint API. Althought there's a function called
snd_pcm_hw_constraint_step, but this function can't be used in the
situation referred in the last mail which one hw parameter should be
aligned to the other hw parameter.

    I've implement a snd_pcm_hw_constraint_aligned function based on
snd_interval_step.

    The patch is based on linux-2.6.31-rc6, and I've tested.


Signed-off-by: Shine Liu <shinel@foxmail.com>
-------------------------------------------------------------------

--- a/include/sound/pcm.h	2009-08-14 06:43:34.000000000 +0800
+++ b/include/sound/pcm.h	2009-08-20 14:29:13.000000000 +0800
@@ -790,6 +790,10 @@
 			       unsigned int cond,
 			       snd_pcm_hw_param_t var,
 			       unsigned long step);
+int snd_pcm_hw_constraint_aligned(struct snd_pcm_runtime *runtime,
+			       unsigned int cond,
+			       snd_pcm_hw_param_t var,
+			       snd_pcm_hw_param_t unit);
 int snd_pcm_hw_constraint_pow2(struct snd_pcm_runtime *runtime,
 			       unsigned int cond,
 			       snd_pcm_hw_param_t var);
--- a/sound/core/pcm_lib.c	2009-08-19 13:12:47.000000000 +0800
+++ b/sound/core/pcm_lib.c	2009-08-20 14:25:53.000000000 +0800
@@ -1319,6 +1319,33 @@
 
 EXPORT_SYMBOL(snd_pcm_hw_constraint_step);
 
+static int snd_pcm_hw_rule_aligned(struct snd_pcm_hw_params *params,
+				struct snd_pcm_hw_rule *rule)
+{
+	struct snd_interval * i = hw_param_interval(params, rule->deps[0]);
+	unsigned int unit = snd_interval_value(i);
+	return snd_interval_step(hw_param_interval(params, rule->var), 0, unit);
+}
+
+/**
+ * snd_pcm_hw_constraint_aligned - add a hw constraint alignment rule
+ * @runtime: PCM runtime instance
+ * @cond: condition bits
+ * @var: hw_params variable to apply the alignment constraint
+ * @unit: hw_params variable to provid the alignment unit
+ */
+int snd_pcm_hw_constraint_aligned(struct snd_pcm_runtime *runtime,
+			       unsigned int cond,
+			       snd_pcm_hw_param_t var,
+			       snd_pcm_hw_param_t unit)
+{
+	return snd_pcm_hw_rule_add(runtime, cond, var, 
+				   snd_pcm_hw_rule_aligned, (void *) 0,
+				   unit, -1);
+}
+
+EXPORT_SYMBOL(snd_pcm_hw_constraint_aligned);
+
 static int snd_pcm_hw_rule_pow2(struct snd_pcm_hw_params *params, struct snd_pcm_hw_rule *rule)
 {
 	static unsigned int pow2_sizes[] = {


> > > 
> > > What hardware is it?
> > 
> > Yes, but there's no constraint code currently to force to align the
> > period size to the buffer size. The bug occurs on linux-2.6.31-rc6 on
> > ASoC s3c24xx platform.
> > 
> > The constraint to force to align the period size to the buffer size
> > should not be hardware depended, it shoud be done in the generic layer,
> > is it?
> 
> It is hardware dependent, i.e. how the irq is generated.
> If the irq is generated in a way like timer, the period size doesn't
> have to be aligned with the buffer size.  But your case doesn't look
> like that.
> 
> 
> Takashi
> 
> 
> 
