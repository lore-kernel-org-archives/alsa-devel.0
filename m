From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: PCM extra attributes
Date: Thu, 25 Jul 2013 10:06:52 +0200
Message-ID: <51F0DC9C.5090008@perex.cz>
References: <20130724170919.GD18642@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 23B4D26030F
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 10:06:53 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "Vinnakota,
 Lakshmi N <lakshmi.n.vinnakota@intel.com>"@vkoul-udesk3.iind.intel.com
List-Id: alsa-devel@alsa-project.org

Date 24.7.2013 19:09, Vinod Koul wrote:
> Hey Takashi,
> 
> We were looking to find the substream index in the userspace for the device
> opened (in case we support multiple substreams and mix them). Since we also
> wanted to have some specific alsa controls for each substream the problem of not
> knowing substream in usermode make stuff interesting!

The substream/subdevice index is in the snd_pcm_info field, so you can
correlate the PCM with the controls from the control API.

snd_pcm_info_get_subdevice()

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
