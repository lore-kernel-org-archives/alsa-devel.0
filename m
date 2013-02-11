From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH] compress: add support for gapless playback
Date: Mon, 11 Feb 2013 06:55:58 -0800
Message-ID: <20130211145558.GH3789@intel.com>
References: <1360585365-16891-1-git-send-email-vinod.koul@intel.com>
 <s5htxpjotmp.wl%tiwai@suse.de> <20130211134147.GG3789@intel.com>
 <s5hobfqq5jr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9417F261670
 for <alsa-devel@alsa-project.org>; Mon, 11 Feb 2013 16:20:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hobfqq5jr.wl%tiwai@suse.de>
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

On Mon, Feb 11, 2013 at 03:38:32PM +0100, Takashi Iwai wrote:
> Well, the question is how this value change is supposed.  I guess it's
> not defined precisely yet.
> 
> It'd make sense to clear padding or such automatically at each new
> stream switch, indeed.  OTOH, what if a metadata is supposed to be
> kept for all tracks (e.g. something like the playback speed control)?
> 
> So, this won't be only a question about bookkeeping in the compress
> core, but rather an API question.  If all metadata are supposed to be
> cleared at stream change, it's fine -- the refresh of all metadata by
> user-space is mandatory.  OTOH, if the metadata are never changed
> unless the stream is (re-)prepared, again, user-space has to manage
> all metadata by itself.  There is no big difference between them.
> The difference is what happens if user-space doesn't update.
> 
> If the behavior is defined per each parameter, maybe it's good for
> user-space, but then the driver (or comr core) becomes slightly more
> complex since it needs to clear some data selectively.
Current ones would be changed for every track, but then some wouldnt.
So its best left to userspace. So right now we have two things:
- add single key/value only
- or pad up struct.

I am okay with either :-)

--
~Vinod
