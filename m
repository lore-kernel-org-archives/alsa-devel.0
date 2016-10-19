From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/2] topology: Support widgets' stream name
 and file inclusion for text conf file
Date: Wed, 19 Oct 2016 09:15:08 +0530
Message-ID: <20161019034507.GI2467@localhost>
References: <cover.1476683054.git.mengdong.lin@linux.intel.com>
 <s5hbmyj6syh.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id B23712659AA
 for <alsa-devel@alsa-project.org>; Wed, 19 Oct 2016 05:36:14 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hbmyj6syh.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, mengdong.lin@linux.intel.com, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 17, 2016 at 02:49:42PM +0200, Takashi Iwai wrote:
> On Mon, 17 Oct 2016 07:55:21 +0200,
> mengdong.lin@linux.intel.com wrote:
> > 
> > From: Mengdong Lin <mengdong.lin@linux.intel.com>
> > 
> > This series doesn't require or cause any ABI updates. It doesn't need the
> > kernel patches that trying to udpate ABI from v4 or v5.
> > 
> > It just fix a missing feature and enhance text conf file to support
> > including files to control the increasing size of text conf files.
> 
> The inclusion of a file can be done in alsaconf syntax via <xxx>,
> too.  We may extend it if needed instead?

Ah that's interesting... Am fine either way.

> The patches themselves look OK, so I'm not strongly against merging
> them, but just to make sure our standpoint.

The last SKL conf became a bit bigger, so for readability we though we can
have different files, one for module instances, one for tuples and then
finally one including these two which has the graph..

-- 
~Vinod
