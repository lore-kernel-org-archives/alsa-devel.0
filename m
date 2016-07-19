From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH v2 0/5] topology: Enhance support for
	private data
Date: Tue, 19 Jul 2016 14:14:12 +0900
Message-ID: <578DB724.8040204@sakamocchi.jp>
References: <cover.1468583255.git.mengdong.lin@linux.intel.com>
 <578A2F73.8080508@sakamocchi.jp> <578C4352.1040804@linux.intel.com>
 <578C5057.7020708@sakamocchi.jp>
 <F46914AEC2663F4A9BB62374E5EEF8F84BA8441C@shsmsx102.ccr.corp.intel.com>
 <20160719035950.GC9681@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id 74888265546
 for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2016 07:14:15 +0200 (CEST)
In-Reply-To: <20160719035950.GC9681@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>, "Lin, Mengdong" <mengdong.lin@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mengdong Lin <mengdong.lin@linux.intel.com>, "tiwai@suse.de" <tiwai@suse.de>, "broonie@kernel.org" <broonie@kernel.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>, "Nc, Shreyas" <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

On Jul 19 2016 12:59, Vinod Koul wrote:
>> Yes, you're right. snd_ctl_new1() dropped SNDRV_CTL_ELEM_ACCESS_USER flag.
>> I'll remove this from the topology user space tool to avoid confusion.
>
> Oh no, that won't be a good idea.
>
> We would like to specify the access for controls from topology. Some
> controls can be read only and some write only :)
>
> For example, any VU-meter controls should be read-only. Similarly if we have
> some user data being sent to some modules which can do do all fancy audio
> detection then these controls should be write-only.

?

I just suggested to remove 'user' from topology implementation in 
userspace library. You can still control access rights of control 
elements by adding enough flags; 'read' or 'write' 
(SNDRV_CTL_ELEM_ACCESS_READ or SNDRV_CTL_ELEM_ACCESS_WRITE). 
SNDRV_CTL_ELEM_ACCESS_USER has no relationship to your purposes.

When a control element has SNDRV_CTL_ELEM_ACCESS_USER flag, a control 
element set including the element has below operations;
  - struct snd_kcontrol.info = snd_ctl_elem_user_enum_info or
                               snd_ctl_elem_user_info
  - struct snd_kcontrol.get = snd_ctl_elem_user_get
  - struct snd_kcontrol.put = snd_ctl_elem_user_put
  - struct snd_kcontrol.tlv.c = snd_ctl_elem_user_tlv

When userland applications call ioctl(2) with SNDRV_CTL_IOCTL_ELEM_ADD, 
then ALSA ctl core adds new control element set. The 'USER' flag is used 
only for this case.

I think it better for you to read 'sound/core/control.c' or my test 
program in alsa-lib source.
http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=test/user-ctl-element-set.c


Regards

Takashi Sakamoto
