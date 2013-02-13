From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] compress: add support for gapless playback
Date: Wed, 13 Feb 2013 05:39:03 -0800
Message-ID: <20130213133903.GF17659@intel.com>
References: <1360693915-22595-1-git-send-email-vinod.koul@intel.com>
 <s5hobfovijf.wl%tiwai@suse.de> <20130213063547.GD17659@intel.com>
 <s5hhalgvf4k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 62C88265112
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2013 15:03:33 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hhalgvf4k.wl%tiwai@suse.de>
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
Cc: Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Wed, Feb 13, 2013 at 08:37:15AM +0100, Takashi Iwai wrote:
> At Tue, 12 Feb 2013 22:35:47 -0800,
> Vinod Koul wrote:
> > 
> > On Wed, Feb 13, 2013 at 07:23:32AM +0100, Takashi Iwai wrote:
> > > But this makes difficult to know which parameter is unavailable in
> > > this kernel, as already mentioned in the thread.  You need to add
> > > another ioctl or add a mask in the struct.  Or, take back to single
> > > key/value pairs, so user can see the -ENOENT or such error for
> > > non-existing parameters.
> > Right, but we have the API version.
> 
> But what if a driver doesn't support a particular metadata?
> Or would you mandate for every driver to support all metadata?
yes you have point. We cant expect everyone to support all metadate.
So I think going back to simple single key/value is easy.

Driver cna implement what it supports and return error for ones it doesn't. This
becomes scalable as well.
But we can't keep them in core as we dont know which ones will change...

Expect updated patch soon :)

--
~Vinod
