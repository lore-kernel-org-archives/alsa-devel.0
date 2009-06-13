From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC PATCH] ASoC: au1x: platform
	driver	restructuring
Date: Sat, 13 Jun 2009 21:43:16 +0100
Message-ID: <20090613204315.GA3665@sirena.org.uk>
References: <4A33BEF0.6020602@gmail.com> <20090613174424.GA19484@sirena.org.uk>
	<f861ec6f0906131317tc0fff56k173e0bd17765b500@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id EA21B243B8
	for <alsa-devel@alsa-project.org>;
	Sat, 13 Jun 2009 22:43:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <f861ec6f0906131317tc0fff56k173e0bd17765b500@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 13, 2009 at 10:17:15PM +0200, Manuel Lauss wrote:
> On Sat, Jun 13, 2009 at 7:44 PM, Mark

> > I'm don't think this is a good idea - it will remove any sequencing
> > between the suspend of the various ASoC device components, meaning that
> > the AC97 controller could suspend before the rest of ASoC. =A0This would

> Reverted back,

OK, when you do resubmit you might want to check for the patch below
should make it in shortly:

>From 831dc0f10f7b2a4856094ff160c018bf19f77527 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sat, 13 Jun 2009 19:55:02 +0100
Subject: [PATCH] ASoC: Add stub suspend and resume calls for ASoC subdevices

Now that ASoC subdevices can be regular devices they can have normal
suspend and resume calls from their buses.  However, suspending them
individually is not desirable since this can lead to problems such as
pops and clicks from devices being suspended with their signals being
amplified or clocks being stopped suddenly.

This will be resolved by having the normal device model suspend and
resume calls call into ASoC which will suspend the entire card while any
of its components are suspended.  At present this is not yet implemented
but in order to aid the transition of drivers to the standard device
model this patch adds API calls for the notifications.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    5 +++++
 sound/soc/soc-core.c |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 5297ba7..e6704c0 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -192,6 +192,11 @@ void snd_soc_unregister_platform(struct snd_soc_platfo=
rm *platform);
 int snd_soc_register_codec(struct snd_soc_codec *codec);
 void snd_soc_unregister_codec(struct snd_soc_codec *codec);
 =

+#ifdef CONFIG_PM
+int snd_soc_suspend_device(struct device *dev);
+int snd_soc_resume_device(struct device *dev);
+#endif
+
 /* pcm <-> DAI connect */
 void snd_soc_free_pcms(struct snd_soc_device *socdev);
 int snd_soc_new_pcms(struct snd_soc_device *socdev, int idx, const char *x=
id);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index e1a920c..4414117 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -788,6 +788,45 @@ static int soc_resume(struct platform_device *pdev)
 	return 0;
 }
 =

+/**
+ * snd_soc_suspend_device: Notify core of device suspend
+ *
+ * @dev: Device being suspended.
+ *
+ * In order to ensure that the entire audio subsystem is suspended in a
+ * coordinated fashion ASoC devices should suspend themselves when
+ * called by ASoC.  When the standard kernel suspend process asks the
+ * device to suspend it should call this function to initiate a suspend
+ * of the entire ASoC card.
+ *
+ * \note Currently this function is stubbed out.
+ */
+int snd_soc_suspend_device(struct device *dev)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_suspend_device);
+
+/**
+ * snd_soc_resume_device: Notify core of device resume
+ *
+ * @dev: Device being resumed.
+ *
+ * In order to ensure that the entire audio subsystem is resumed in a
+ * coordinated fashion ASoC devices should resume themselves when called
+ * by ASoC.  When the standard kernel resume process asks the device
+ * to resume it should call this function.  Once all the components of
+ * the card have notified that they are ready to be resumed the card
+ * will be resumed.
+ *
+ * \note Currently this function is stubbed out.
+ */
+int snd_soc_resume_device(struct device *dev)
+{
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snd_soc_resume_device);
+
 #else
 #define soc_suspend	NULL
 #define soc_resume	NULL
-- =

1.6.3.1
