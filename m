From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3] amixer: skip showing asoc tlv byte
	controls
Date: Thu, 28 Jan 2016 13:54:24 +0530
Message-ID: <20160128082424.GI11130@localhost>
References: <1453965966-27661-1-git-send-email-vinod.koul@intel.com>
 <s5hegd2maa2.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 09CF82654F6
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2016 09:20:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hegd2maa2.wl-tiwai@suse.de>
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

On Thu, Jan 28, 2016 at 08:29:57AM +0100, Takashi Iwai wrote:
> On Thu, 28 Jan 2016 08:26:06 +0100,
> Vinod Koul wrote:
> > 
> > ASoC TLV Byte controls are very large size controls so we should add new
> > options for these. So skip dumping contents for these.
> > 
> > $amixer -c0 cget numid=16
> > numid=16,iface=MIXER,name='mdl params'
> >   ; type=BYTES,access=-----RW-,values=30336
> >   : ASoC TLV Byte control, skipping bytes dump
> 
> Use semicolon instead.

Sure, I tried to use the existing style, what is the interpretation of
these?

-- 
~Vinod
