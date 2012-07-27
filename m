From: "Marty Christian (cmarty@hsr.ch)" <cmarty@hsr.ch>
Subject: Adding an ASoC codec,
 ads1178 in TDM mode without a control interface
Date: Fri, 27 Jul 2012 08:40:44 +0000
Message-ID: <0D2A6624B19075418DB0AD1D6BBA2D8D2AF31513@SID00202.hsr.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.hsr.ch (mx2.hsr.ch [152.96.36.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C46CD265FD9
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 10:40:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by mx2.hsr.ch (Postfix) with ESMTP id C732A565F
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 10:41:00 +0200 (CEST)
Received: from mx2.hsr.ch ([127.0.0.1])
 by localhost (mx2.hsr.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id rsVneaAOB5pO for <alsa-devel@alsa-project.org>;
 Fri, 27 Jul 2012 10:40:54 +0200 (CEST)
Received: from webmail.hsr.ch (unknown [152.96.21.201])
 by mx2.hsr.ch (Postfix) with ESMTP id 9566C4ECA
 for <alsa-devel@alsa-project.org>; Fri, 27 Jul 2012 10:40:54 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

I'm running an Angstrom 2012.5 (3.2.18) on a Beaglebone. A daughterboard with an ads1278 ADC on it is connected to mcasp0, which I would like to use with alsa in TDM mode. This device does not have an I2C/SPI control interface. It is very similar to the ads1178 device, that's why I try to get this one running.

I assume that it is probably the best to use the davinci-pcm-audio platform driver.
I modified following:
Index: git/arch/arm/mach-omap2/devices.c
===================================================================
--- git.orig/arch/arm/mach-omap2/devices.c    2012-07-20 16:22:26.324602816 +0200
+++ git/arch/arm/mach-omap2/devices.c          2012-07-26 13:20:17.124821103 +0200
@@ -231,10 +231,16 @@
               .id                          = -1,
};
+struct platform_device ads117x_codec= {
+             .name                  = "ads117x-codec",
+             .id                          = -1,
+};
+
static void am33xx_init_pcm(void)
{
-              printk("cape: pcm register");
+             printk("Multisensor cape: pcm register");
               platform_device_register(&am33xx_pcm_device);
+             platform_device_register(&ads117x_codec);
}
 #else

After this changes, I can find codec and dai in /sys/kernel/debug/asoc:
root@beaglebone:/sys/kernel/debug/asoc# cat codecs
tlv320aic3x-codec.3-001b
ads117x-codec
root@beaglebone:/sys/kernel/debug/asoc# cat dais
davinci-mcasp.1
davinci-mcasp.0
tlv320aic3x-hifi
ads117x-hifi
root@beaglebone:/sys/kernel/debug/asoc# cat platforms
davinci-pcm-audio
snd-soc-dummy
root@beaglebone:/sys/kernel/debug/asoc#

If I now try to add this to snd_soc_dai_link, the kernel panics while booting:
{
                               .name = "ADS117X",
                               .stream_name = "ADS117X",
                               .cpu_dai_name = "davinci-mcasp.0",
                               .codec_dai_name = "ads117x-hifi",
                               .codec_name = "ads117x-codec",
                               .platform_name = "davinci-pcm-audio",
                               .init = evm_adsadc_init,
                               .ops = &evm_adc_ops,
}

Does anybody have an idea how it comes to this?

Another thing I don't understand is, why do we register a platform in ads117.c?
static int __init ads117x_init(void)
{
                return platform_driver_register(&ads117x_codec_driver);
}

The old version used to register a snd_soc_dai_driver:
static int __init ads117x_modinit(void)
{
                return snd_soc_register_dai(&ads117x_dai);
}

Thanks in advance!
hitsch
