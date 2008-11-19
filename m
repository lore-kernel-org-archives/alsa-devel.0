From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: [PATCH 0/4] multi-channel HDMI audio support
Date: Wed, 19 Nov 2008 14:42:16 +0800
Message-ID: <20081119064216.GA16545@localhost>
References: <20081119005614.431653658@linux.intel.com>
	<s5hk5b0w76z.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from azsmga102.ch.intel.com (mga12.intel.com [143.182.124.36])
	by alsa0.perex.cz (Postfix) with ESMTP id ABD142457E
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 07:42:26 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hk5b0w76z.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 19, 2008 at 07:39:16AM +0100, Takashi Iwai wrote:
> At Wed, 19 Nov 2008 08:56:14 +0800,
> Wu Fengguang wrote:
> > 
> > Hi Takashi,
> > 
> > This patchset attempts to support multi-channel HDMI audio.
> > 
> > It contains two basic operations:
> > 
> > - setup the CA(channel-allocation) byte in the audio infoframe
> > - setup the converter channel to HDMI slot mapping
> > 
> > Please read patch 3 for more detailed descriptions:
> > 
> > 	[PATCH 1/4] hda: make standalone hdmi_fill_audio_infoframe()                               
> > 	[PATCH 2/4] hda: make global snd_print_channel_allocation()                       
> > 	[PATCH 3/4] hda: HDMI channel allocations for audio infoframe                               
> > 	[PATCH 4/4] hda: HDMI channel mapping cleanups                                               
> > 
> > The current implementation only does minimal works that ensure multi-channel
> > audio playing out. However the wrong speakers may be selected. We could
> > elaborate the framework/policy if it proves to be a problem.
> 
> Thanks, applied all patches now.

Thank you, I'll post more cleanups after a while :-)

Regards,
Fengguang
