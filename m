From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: asoc device probing and dai question
Date: Thu, 2 Dec 2010 16:31:07 +0530
Message-ID: <438BB0150E931F4B9CE701519A44630104BEE140D2@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A3F010381A
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 12:03:37 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Harsha, Priya" <priya.harsha@intel.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

In our driver, the machine probe creates the soc-audio device. I am adding the 
codec and platform device in my soc-device. But the probe for the codec doesn't 
get called unless we add the cpu and codec dais in the machine probe. I saw the 
soc-core code and looks like it checks if cpu and codec dais are registerd if so 
then only proceeds and calls the codec probe.

So should I continue to register the dai for both cpu and codec in machine 
probe. I didn't see other driver in soc/ doing this, so did I miss something.

Code:
In m/c driver... (the m/c driver probe is called by kernel when it finds this 
device, and I register it as a platform device)

/* Audio machine driver */
static struct snd_soc_card snd_soc_intelmid_card = {
        .name = "intel_mid_sound_card",
        .platform = &intelmid_soc_platform,
        .dai_link = intelmid_msic_dai,
        .num_links = 1,
};

/* Audio subsystem */
static struct snd_soc_device intelmid_snd_devdata = {
        .card = &snd_soc_intelmid_card,
        .codec_dev = &intel_msic_codec,
};
int __devinit snd_intelmid_mc_probe(struct platform_device *pdev)
{
        int ret_val;

        snd_printk(KERN_DEBUG "snd_intelmad_probe called\n");

        ret_val = snd_soc_register_dais(mid_bsp_dai, ARRAY_SIZE(mid_bsp_dai));
        ret_val = snd_soc_register_dais(intel_msic_dais, ARRAY_SIZE(intel_msic_dais));

        intelmid_snd_device = platform_device_alloc("soc-audio", -1);
        if (!intelmid_snd_device) {
                snd_printk(KERN_ERR "Platform device allocation failed\n");
                return -ENOMEM;
        }

        platform_set_drvdata(intelmid_snd_device, &intelmid_snd_devdata);
        
        intelmid_snd_devdata.dev = &intelmid_snd_device->dev;

        ret_val = platform_device_add(intelmid_snd_device);
        if (ret_val) {
                snd_printk(KERN_ERR "Unable to add platform device\n");
                platform_device_put(intelmid_snd_device);
        }
        return ret_val;
}

In platform init (note I don't have probe for platform)
static int __init intel_mid_soc_platform_init(void)
{
        snd_printk(KERN_DEBUG "intel_mid_soc_platform_init called\n");
        return snd_soc_register_platform(&intelmid_soc_platform);
}

Thanks
Vinod
