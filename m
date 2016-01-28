From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2] amixer: skip showing asoc tlv byte
	controls
Date: Thu, 28 Jan 2016 12:10:11 +0530
Message-ID: <20160128064011.GE11130@localhost>
References: <1453956582-27254-1-git-send-email-vinod.koul@intel.com>
 <s5hy4bameqa.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 799082654B3
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2016 07:36:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hy4bameqa.wl-tiwai@suse.de>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 28, 2016 at 06:53:49AM +0100, Takashi Iwai wrote:
> On Thu, 28 Jan 2016 05:49:42 +0100,
> Vinod Koul wrote:
> > 
> > ASoC TLV Byte controls are very large size controls so we should add new
> > options for these. So skip dumping contents for these.
> > 
> > $amixer -c0 cget numid=16
> > numid=16,iface=MIXER,name='mdl params'
> >   ; type=BYTES,access=-----RW-,values=30336
> >   : ASoC TLV Byte control, skipping bytes dump
> > 
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> 
> No, as I wrote before, checking the type isn't enough.
> Assigning a TLV to BYTES type doesn't mean necessarily that it's an
> ASoC EXT control.  You need to check the r/w capabilities as well.

Oops missed that part.

So am making it

if (type == SND_CTL_ELEM_TYPE_BYTES &&
	(snd_ctl_elem_info_is_tlv_readable(info) ||
	snd_ctl_elem_info_is_tlv_writable(info))) {

But this control can be read only or write only. Like a module doesnt allow
read, or some is read only so OR should be good here

Also should it check it is not normal read/write ?

Thanks

-- 
~Vinod
