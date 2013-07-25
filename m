From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: PCM extra attributes
Date: Thu, 25 Jul 2013 11:54:28 +0800
Message-ID: <CAN8ccia2_3b9Ua5Ze49ZMxx38GreYvaKXWYsdb1EnqyfL6LZGQ@mail.gmail.com>
References: <20130724170919.GD18642@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f44.google.com (mail-oa0-f44.google.com
 [209.85.219.44])
 by alsa0.perex.cz (Postfix) with ESMTP id B3917265578
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 05:54:29 +0200 (CEST)
Received: by mail-oa0-f44.google.com with SMTP id l10so3137581oag.31
 for <alsa-devel@alsa-project.org>; Wed, 24 Jul 2013 20:54:28 -0700 (PDT)
In-Reply-To: <20130724170919.GD18642@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, "Vinnakota,
 Lakshmi N <lakshmi.n.vinnakota@intel.com>"@vkoul-udesk3.iind.intel.com
List-Id: alsa-devel@alsa-project.org

>
> We were looking to find the substream index in the userspace for the device
> opened (in case we support multiple substreams and mix them).


http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___info.html

snd_pcm_info_get_subdevice() - Get subdevice from a PCM info container

snd_pcm_info_get_subdevice_name() - Get subdevice name from a PCM info
container

snd_pcm_info_get_subdevice_count() - Get subdevices count from a PCM info
container

snd_pcm_info_get_subdevice_avail() - Get avail subdevices count from a PCM
info container

snd_pcm_info_set_subdevice - Set wanted subdevice inside a PCM info
container


>
> Since we also wanted to have some specific alsa controls for each
> substream the problem of not knowing substream in usermode make stuff
> interesting!
>

The subdevices of a device need to same format , rate , channels, period
and buffer constraints


http://git.alsa-project.org/?p=alsa-tools.git;a=tree;f=hwmixvolume
