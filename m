From: "Yang, Libin" <libin.yang@intel.com>
Subject: Re: [RFC PATCH v3 0/3] support DP MST audio
Date: Thu, 20 Oct 2016 07:23:57 +0000
Message-ID: <96A12704CE18D347B625EE2D4A099D194FA49B7E@SHSMSX103.ccr.corp.intel.com>
References: <1476344977-147193-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id C0F522666CF
 for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2016 09:24:00 +0200 (CEST)
In-Reply-To: <1476344977-147193-1-git-send-email-libin.yang@linux.intel.com>
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
To: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Lin, Mengdong" <mengdong.lin@intel.com>, "libin.yang@linux.intel.com" <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Pandiyan, Dhinakaran has root caused the MST flicker issue. He is
still working with gfx team to decide how to make the patch.
The draft patch can be found:
https://patchwork.freedesktop.org/patch/115585/

BTW: Not sure if you have time to review my updated
audio patches. Thanks.

Regards,
Libin


> -----Original Message-----
> From: libin.yang@linux.intel.com [mailto:libin.yang@linux.intel.com]
> Sent: Thursday, October 13, 2016 3:50 PM
> To: alsa-devel@alsa-project.org; tiwai@suse.de
> Cc: Lin, Mengdong <mengdong.lin@intel.com>; Yang, Libin
> <libin.yang@intel.com>; Libin Yang <libin.yang@linux.intel.com>
> Subject: [alsa-devel] [RFC PATCH v3 0/3] support DP MST audio
> 
> From: Libin Yang <libin.yang@linux.intel.com>
> 
> This patchset starts to support DP MST audio.
> 
> This patchset is based on drm-intel-nightly on
> git://anongit.freedesktop.org/drm-intel
> 
> Libin Yang (3):
>   ALSA: hda - add DP mst verb support
>   ALSA: hda - add DP mst audio support
>   ALSA: Documentation about HDA DP MST pin init and connection
> 
>  Documentation/sound/alsa/HD-Audio-DP-MST-audio.txt |  17 ++
>  sound/pci/hda/hda_codec.c                          |  77 ++++++-
>  sound/pci/hda/hda_codec.h                          |   3 +
>  sound/pci/hda/patch_hdmi.c                         | 243 ++++++++++++++++-----
>  4 files changed, 285 insertions(+), 55 deletions(-)
> 
> --
> 1.9.1
