From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCHv2 08/20] OMAP: McBSP: Add link DMA mode
	selection
Date: Wed, 12 Aug 2009 14:51:26 +0300
Message-ID: <20090812145126.bd028e6f.jhnikula__34496.1813455031$1250077822$gmane$org@gmail.com>
References: <1249995931-26015-1-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-2-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-3-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-4-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-5-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-6-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-7-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-8-git-send-email-eduardo.valentin@nokia.com>
	<1249995931-26015-9-git-send-email-eduardo.valentin@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1249995931-26015-9-git-send-email-eduardo.valentin@nokia.com>
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
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, "\\\"Ujfalusi Peter (Nokia-D/Tampere)\\\"" <peter.ujfalusi@nokia.com>, ALSA-Devel <alsa-devel@vger.kernel.org>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 11 Aug 2009 16:05:19 +0300
Eduardo Valentin <eduardo.valentin@nokia.com> wrote:

> From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> 
> It adds a new sysfs file, where the user can configure the mcbsp mode to use.
> If the mcbsp channel is in use, it does not allow the change.
> Than in omap_pcm_open we can call the omap_mcbsp_get_opmode to get the mode,
> store it, than use it to implement the different modes.

...
> +static ssize_t dma_op_mode_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
> +	int dma_op_mode;
> +
> +	spin_lock_irq(&mcbsp->lock);
> +	dma_op_mode = mcbsp->dma_op_mode;
> +	spin_unlock_irq(&mcbsp->lock);
> +
> +	return sprintf(buf, "current mode: %d\n"
> +			"possible mode values are:\n"
> +			"%d - %s\n"
> +			"%d - %s\n"
> +			"%d - %s\n",
> +			dma_op_mode,
> +			MCBSP_DMA_MODE_ELEMENT, "element mode",
> +			MCBSP_DMA_MODE_THRESHOLD, "threshold mode",
> +			MCBSP_DMA_MODE_FRAME, "frame mode");
> +}
> +

Btw: I hacked a patch below on top of the set for setting and reading the
operating mode in ascii. Freely usable, no guarantee :-)


-- 
Jarkko

--- 
diff --git a/arch/arm/plat-omap/mcbsp.c b/arch/arm/plat-omap/mcbsp.c
index 50a9fea..e637a28 100644
--- a/arch/arm/plat-omap/mcbsp.c
+++ b/arch/arm/plat-omap/mcbsp.c
@@ -1147,6 +1147,10 @@ static DEVICE_ATTR(prop, 0644, prop##_show, prop##_store);
 THRESHOLD_PROP_BUILDER(max_tx_thres);
 THRESHOLD_PROP_BUILDER(max_rx_thres);
 
+static const char *dma_op_modes[] = {
+	"element", "threshold", "frame",
+};
+
 static ssize_t dma_op_mode_show(struct device *dev,
 			struct device_attribute *attr, char *buf)
 {
@@ -1157,15 +1161,7 @@ static ssize_t dma_op_mode_show(struct device *dev,
 	dma_op_mode = mcbsp->dma_op_mode;
 	spin_unlock_irq(&mcbsp->lock);
 
-	return sprintf(buf, "current mode: %d\n"
-			"possible mode values are:\n"
-			"%d - %s\n"
-			"%d - %s\n"
-			"%d - %s\n",
-			dma_op_mode,
-			MCBSP_DMA_MODE_ELEMENT, "element mode",
-			MCBSP_DMA_MODE_THRESHOLD, "threshold mode",
-			MCBSP_DMA_MODE_FRAME, "frame mode");
+	return sprintf(buf, "%s\n", dma_op_modes[dma_op_mode]);
 }
 
 static ssize_t dma_op_mode_store(struct device *dev,
@@ -1173,12 +1169,19 @@ static ssize_t dma_op_mode_store(struct device *dev,
 				const char *buf, size_t size)
 {
 	struct omap_mcbsp *mcbsp = dev_get_drvdata(dev);
-	unsigned long val;
-	int status;
-
-	status = strict_strtoul(buf, 0, &val);
-	if (status)
-		return status;
+	const char * const *s;
+	char *p;
+	int len, mode = 0;
+
+	p = memchr(buf, '\n', size);
+	len = p ? p - buf : size;
+
+	for (s = &dma_op_modes[mode];
+	     mode < ARRAY_SIZE(dma_op_modes); s++, mode++)
+		if (*s && len == strlen(*s) && !strncmp(buf, *s, len))
+			break;
+	if (mode == ARRAY_SIZE(dma_op_modes))
+		return -EINVAL;
 
 	spin_lock_irq(&mcbsp->lock);
 
@@ -1187,12 +1190,7 @@ static ssize_t dma_op_mode_store(struct device *dev,
 		goto unlock;
 	}
 
-	if (val > MCBSP_DMA_MODE_FRAME || val < MCBSP_DMA_MODE_ELEMENT) {
-		size = -EINVAL;
-		goto unlock;
-	}
-
-	mcbsp->dma_op_mode = val;
+	mcbsp->dma_op_mode = mode;
 
 unlock:
 	spin_unlock_irq(&mcbsp->lock);

