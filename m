From: "Ughreja, Rakesh A" <rakesh.a.ughreja@intel.com>
Subject: Re: [RFC v2 00/11] Enable HDA Codec support on
	Intel	Platforms (Series2)
Date: Tue, 12 Dec 2017 18:25:57 +0000
Message-ID: <85DFEED57DC57344B2483EF7BF8CB60579AD5429@BGSMSX104.gar.corp.intel.com>
References: <1512989583-10877-1-git-send-email-rakesh.a.ughreja@intel.com>
 <s5hbmj5mrts.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579AD2978@BGSMSX104.gar.corp.intel.com>
 <s5hinddl28l.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579AD2F48@BGSMSX104.gar.corp.intel.com>
 <s5hefo1aymr.wl-tiwai@suse.de>
 <85DFEED57DC57344B2483EF7BF8CB60579AD52D3@BGSMSX104.gar.corp.intel.com>
 <s5h609b99fw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by alsa0.perex.cz (Postfix) with ESMTP id 8FB9F2671B1
 for <alsa-devel@alsa-project.org>; Tue, 12 Dec 2017 19:26:02 +0100 (CET)
In-Reply-To: <s5h609b99fw.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Koul,
 Vinod" <vinod.koul@intel.com>, "pierre-louis.bossart@linux.intel.com" <pierre-louis.bossart@linux.intel.com>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, Patches Audio <patches.audio@intel.com>, "broonie@kernel.org" <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org



>-----Original Message-----
>From: alsa-devel-bounces@alsa-project.org [mailto:alsa-devel-bounces@alsa-
>project.org] On Behalf Of Takashi Iwai
>Sent: Tuesday, December 12, 2017 10:21 PM
>To: Ughreja, Rakesh A <rakesh.a.ughreja@intel.com>
>Cc: alsa-devel@alsa-project.org; Koul, Vinod <vinod.koul@intel.com>; pierre-
>louis.bossart@linux.intel.com; liam.r.girdwood@linux.intel.com; Patches Audio
><patches.audio@intel.com>; broonie@kernel.org
>Subject: Re: [alsa-devel] [RFC v2 00/11] Enable HDA Codec support on Intel
>Platforms (Series2)
>


>
>The idea looks good, but I'd prefer different functions instead of
>mutating the behavior depending on the flag.  i.e. keep
>snd_hda_codec_new(), and introduce another API (snd_hda_codec_init()
>or whatever).  ASoC driver can call the latter while the legacy driver
>keeps calling the former.
>
>This would factor out the allocation and snd_hdac_device_init() calls
>from the old snd_hda_codec_new() to a new snd_hda_codec_new().
>snd_hda_codec_init() would do the rest.  snd_hda_codec_new() calls
>snd_hda_codec_init() at the end of the function.
>
>Does this sound good for you?

I think I got this :) Thanks. Here is the skeleton code.
I split the existing function snd_hda_codec_new into two parts.

1. snd_hda_codec_device_init()
2. snd_hda_codec_device_new()

So the new body of existing function snd_hda_codec_new looks like.

int snd_hda_codec_new(struct hda_bus *bus, struct snd_card *card,               
                      unsigned int codec_addr, struct hda_codec **codecp)       
{                                                                               
        int ret;                                                                
                                                                                
        ret = snd_hda_codec_device_init(bus, card, codec_addr, codecp);         
        if (ret < 0)                                                            
                return ret;                                                     
                                                                                
        return snd_hda_codec_device_new(bus, card, codec_addr, *codecp);        
}

The ASoC driver would call only snd_hda_codec_device_new.
If you have any suggestions for the function names, I can change it before
I post the next series.

Now switching over to the id_table problem. In the current series it is accessed
using extern, in the patch_realtek.c file. So we really have two different
KO files. One for legacy HDA driver and second for ASoC HDA driver.

Would you like to keep them as two separate KO files or prefer to have a
single KO file ?
