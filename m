From: thomas schorpp <thomas.schorpp-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ARM: sun7i: Fix HDMI Audio driver's Alsa
 interface and do 8CH IEC60958 output
Date: Fri, 01 Aug 2014 13:40:31 +0200
Message-ID: <53DB7CAF.4020402@gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Return-path: <linux-sunxi+bncBDYY3S6C5QNBBM7Z5WPAKGQES77HXPI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

First shot. HDMI backend seems to work with speaker-test but stream samples wrong order /mapping issues and the Alsa frontend is a stub,
Pulseaudio needs more, still defaults to 2CH and "Analog".

Please test if it switches Your receivers correctly into multichannel pcm mode, strange people with those overexpensed high end 7.1 receivers ;-)

Signed-off-by: Not Yet

-----------
https://github.com/linux-sunxi/linux-sunxi
* stage/sunxi-3.4

diff --git a/drivers/video/sunxi/hdmi/drv_hdmi.c b/drivers/video/sunxi/hdmi/drv_hdmi.c
index 283d2ae..9cf2cc2 100644
--- a/drivers/video/sunxi/hdmi/drv_hdmi.c
+++ b/drivers/video/sunxi/hdmi/drv_hdmi.c
@@ -314,7 +314,7 @@ __s32 Hdmi_init(struct platform_device *dev)
  	if (err)
  		return err;
  
-	audio_info.channel_num = 2;
+	audio_info.channel_num = 8;
  #if 0
  	{ /* for audio test */
  		hdmi_audio_t audio_para;
diff --git a/sound/soc/sunxi/hdmiaudio/sndhdmi.c b/sound/soc/sunxi/hdmiaudio/sndhdmi.c
index 1c306d2..4563010 100644
--- a/sound/soc/sunxi/hdmiaudio/sndhdmi.c
+++ b/sound/soc/sunxi/hdmiaudio/sndhdmi.c
@@ -85,7 +85,9 @@ static int sndhdmi_hw_params(struct snd_pcm_substream *substream,
  		return -EINVAL;
  	}
  
-	if (4 == hdmi_para.channel_num)
+	if (2 < hdmi_para.channel_num)
+		hdmi_para.channel_num = 8;
+	if (2 > hdmi_para.channel_num)
  		hdmi_para.channel_num = 2;
  
  	g_hdmi_func.hdmi_set_audio_para(&hdmi_para);
@@ -129,11 +131,11 @@ struct snd_soc_dai_ops sndhdmi_dai_ops = {
  /* codec dai */
  struct snd_soc_dai_driver sndhdmi_dai = {
  	.name = "sndhdmi",
-	/* playback capabilities */
+	/* playback capabilities, hdmi_core::audio_config() claims 8ch cap */
  	.playback = {
  		.stream_name = "Playback",
-		.channels_min = 1,
-		.channels_max = 2,
+		.channels_min = 2,
+		.channels_max = 8,
  		.rates = SNDHDMI_RATES,
  		.formats = SNDHDMI_FORMATS,
  	},
diff --git a/sound/soc/sunxi/hdmiaudio/sunxi-hdmiaudio.c b/sound/soc/sunxi/hdmiaudio/sunxi-hdmiaudio.c
index 12da1a6..80dd3b9 100644
--- a/sound/soc/sunxi/hdmiaudio/sunxi-hdmiaudio.c
+++ b/sound/soc/sunxi/hdmiaudio/sunxi-hdmiaudio.c
@@ -34,8 +34,8 @@
  #include <plat/sys_config.h>
  #include <plat/dma_compat.h>
  
-static struct sunxi_dma_params sunxi_hdmiaudio_pcm_stereo_out = {
-	.client.name	=	"HDMIAUDIO PCM Stereo out",
+static struct sunxi_dma_params sunxi_hdmiaudio_pcm_iec60958_out = {
+	.client.name	=	"HDMIAUDIO PCM IEC60958 out",
  #if defined CONFIG_ARCH_SUN4I || defined CONFIG_ARCH_SUN5I
  	.channel	=	DMACH_HDMIAUDIO,
  #endif
@@ -67,7 +67,7 @@ static int sunxi_hdmiaudio_hw_params(struct snd_pcm_substream *substream,
  	rtd = substream->private_data;
  
  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		dma_data = &sunxi_hdmiaudio_pcm_stereo_out;
+		dma_data = &sunxi_hdmiaudio_pcm_iec60958_out;
  	else
  		printk("error:hdmiaudio can't support capture:%s,line:%d\n",
  							__func__, __LINE__);
@@ -182,8 +182,8 @@ static struct snd_soc_dai_driver sunxi_hdmiaudio_dai = {
  	.resume			= sunxi_hdmiaudio_resume,
  	.remove			= sunxi_hdmiaudio_dai_remove,
  	.playback		= {
-		.channels_min	= 1,
-		.channels_max	= 2,
+		.channels_min	= 2,
+		.channels_max	= 8,
  		.rates		= SUNXI_HDMI_RATES,
  		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
  	},
diff --git a/sound/soc/sunxi/hdmiaudio/sunxi-hdmipcm.c b/sound/soc/sunxi/hdmiaudio/sunxi-hdmipcm.c
index 4916b51..9ab01ee 100644
--- a/sound/soc/sunxi/hdmiaudio/sunxi-hdmipcm.c
+++ b/sound/soc/sunxi/hdmiaudio/sunxi-hdmipcm.c
@@ -45,8 +45,8 @@ static const struct snd_pcm_hardware sunxi_pcm_hardware = {
  					SNDRV_PCM_RATE_KNOT,
  	.rate_min		= 8000,
  	.rate_max		= 192000,
-	.channels_min		= 1,
-	.channels_max		= 2,
+	.channels_min		= 2,
+	.channels_max		= 8,
  	.buffer_bytes_max	= 128*1024, /* value must be (2^n)Kbyte size */
  	.period_bytes_min	= 1024*4,
  	.period_bytes_max	= 1024*32,
