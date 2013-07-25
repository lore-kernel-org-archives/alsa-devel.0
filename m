From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: PCM extra attributes
Date: Thu, 25 Jul 2013 14:08:10 +0530
Message-ID: <20130725083810.GK18642@intel.com>
References: <20130724170919.GD18642@intel.com>
 <51F0DC9C.5090008@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FDEB2650D1
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 11:16:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51F0DC9C.5090008@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lakshmi.n.vinnakota@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 25, 2013 at 10:06:52AM +0200, Jaroslav Kysela wrote:
> Date 24.7.2013 19:09, Vinod Koul wrote:
> > Hey Takashi,
> > 
> > We were looking to find the substream index in the userspace for the device
> > opened (in case we support multiple substreams and mix them). Since we also
> > wanted to have some specific alsa controls for each substream the problem of not
> > knowing substream in usermode make stuff interesting!
> 
> The substream/subdevice index is in the snd_pcm_info field, so you can
> correlate the PCM with the controls from the control API.
> 
> snd_pcm_info_get_subdevice()
This looks intresting, Thanks Jarsolav and Raymond.

If I get snd_pcm_info after the stream has been created I should see the
subdevice and thus use alsa controls corrorsponding.

Let me test this, it should work

~Vinod
