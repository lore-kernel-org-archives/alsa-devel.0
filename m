From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 2/5] hda - allow up to 10 Azalia codecs
Date: Thu, 13 May 2010 11:03:43 +0800
Message-ID: <20100513030343.GA15790@localhost>
References: <20100512013015.752623810@intel.com>
	<20100512015713.872250021@intel.com> <s5heihhqjb1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 56ECB10389D
	for <alsa-devel@alsa-project.org>;
	Thu, 13 May 2010 05:03:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5heihhqjb1.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, May 12, 2010 at 10:35:46PM +0800, Takashi Iwai wrote:
> At Wed, 12 May 2010 09:30:17 +0800,
> Wu Fengguang wrote:
> > 
> > Currently AZX_MAX_CODECS is defined to 8. Increase it to 10 in order to
> > support the HDMI device indices {3, 7, 8, 9}.
> 
> If I understand correctly, the codec slot number is basically
> independent from the PCM device number assigned.  Hence this change
> shouldn't be necessary unless you really have more than 8 codec
> chips.  Or will be such a high codec address expected soon on new
> Intel platforms?

You are right, it works without this patch. Sorry for the confusion!

> > The HD audio spec allows up to 14 codecs. So we are still within the
> > hardware capacity.
> 
> I thought this was at most 8, so I used the value 0x100 as a special
> bit flag for probe_mask module option :-<
> We'd need to change this if we extend the max codecs...

It may allow 15 codecs in fact. I get the max number from "Figure 32.
Codec Address Assignment Frame":

CODEC Samples Address ** Address 15 is reserved for
 0 1 2 3 ......... 14    link protocol purposes and
                         may not be assigned to
                         CODECs

And STATESTS has bits 14:0 allocated for "SDIN State Change Status Flags
(SDIWAKE)".

However we don't need to increase AZX_MAX_CODECS and probe_mask for now.

Thanks,
Fengguang
