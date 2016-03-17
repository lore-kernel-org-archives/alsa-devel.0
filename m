From: "Lu, Han" <han.lu@intel.com>
Subject: Re: [pulseaudio-discuss]   ASoC and pulseaudio
Date: Thu, 17 Mar 2016 11:23:08 +0000
Message-ID: <B51200AC81AB024499A3C2C9A1BB90A83D3AB8E9@SHSMSX101.ccr.corp.intel.com>
References: <20160314160654.GA2566@sirena.org.uk>
 <1458021688.8522.16.camel@loki> <20160315084544.GF2566@sirena.org.uk>
 <s5hmvq0glxj.wl-tiwai@suse.de> <1458035331.8522.52.camel@loki>
 <s5h8u1kgj3c.wl-tiwai@suse.de> <1458039506.8522.70.camel@loki>
 <20160316145704.GU13211@localhost> <20160316150949.GX2566@sirena.org.uk>
 <s5hwpp2bggh.wl-tiwai@suse.de> <20160316155342.GV13211@localhost>
 <1458151177.3844.50.camel@loki>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id B9C53260831
 for <alsa-devel@alsa-project.org>; Thu, 17 Mar 2016 12:23:17 +0100 (CET)
In-Reply-To: <1458151177.3844.50.camel@loki>
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
To: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>, "Koul, Vinod" <vinod.koul@intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, "han.lu" <han.lu@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: pulseaudio-discuss [mailto:pulseaudio-discuss-
> bounces@lists.freedesktop.org] On Behalf Of Liam Girdwood
> Sent: Thursday, March 17, 2016 2:00 AM
> To: Koul, Vinod <vinod.koul@intel.com>
> Cc: alsa-devel@alsa-project.org; General PulseAudio Discussion <pulseaudio-
> discuss@lists.freedesktop.org>; Takashi Iwai <tiwai@suse.de>; Mark Brown
> <broonie@kernel.org>; han.lu <han.lu@linux.intel.com>; Linux Upstreaming
> Team <linux@endlessm.com>
> Subject: Re: [pulseaudio-discuss] [alsa-devel] ASoC and pulseaudio
> 
> On Wed, 2016-03-16 at 21:23 +0530, Vinod Koul wrote:
> 
> >
> > > Yeah, that should be feasible.  Also, there is a "component" field
> > > assigned to the card.  This is supposed to be referred by user-space
> > > as additional information.  See snd_component_add().
> >
> > Will add this to my ever growing list of things to do... :D
> 
> You don't have to :)
> 
> It's on Han's list.
> 
> Liam
> 

I installed Ubuntu 14.04 to T100 and update the kernel to 4.5.0+ today,
and I tested with a simple patch, which only added long_name in
format "DMI_PRODUCT_NAME:card->name", and now in T100,
command "cat /proc/sound/cards" will print
 0  [bytcrrt5640    ]: bytcr-rt5640 - bytcr-rt5640
                                      T100TA:bytcr-rt5640
Please find details below. I'll continue to add fw name.
Or shall we use sysfs and snd_component_add instead?

>From 511e6f6a606438a977d9e006c4629fa9b967d6a8 Mon Sep 17 00:00:00 2001
From: "Lu, Han" <han.lu@intel.com>
Date: Thu, 17 Mar 2016 16:50:54 +0800
Subject: [PATCH RFC 1/1] Asoc: rt5640: add more machine/board information for
 user

Add more machine/board information for PA and UCM.

Signed-off-by: Lu, Han <han.lu@intel.com>

diff --git a/sound/soc/intel/boards/bytcr_rt5640.c
 b/sound/soc/intel/boards/bytcr_rt5640.c
index 032a2e7..9bd5e21 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -160,6 +160,12 @@ static int byt_rt5640_init(struct snd_soc_pcm_runtime
 *runtime)
        const struct snd_soc_dapm_route *custom_map;
        int num_routes;

+       if (!card->long_name) {
+               card->long_name = dmi_get_system_info(DMI_PRODUCT_NAME);
+               strcat((char *)card->long_name, ":");
+               strcat((char *)card->long_name, card->name);
+       }
+
        card->dapm.idle_bias_off = true;

        rt5640_sel_asrc_clk_src(codec,
--
2.5.0	

BR,
Han
> 
> _______________________________________________
> pulseaudio-discuss mailing list
> pulseaudio-discuss@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss
