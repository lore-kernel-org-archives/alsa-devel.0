From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 0/5] Fix poll error returns
Date: Mon, 9 May 2016 20:49:19 +0530
Message-ID: <20160509151919.GE2274@localhost>
References: <1462370351-15388-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <s5h4ma7qvi4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E6A32654D4
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 17:13:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h4ma7qvi4.wl-tiwai@suse.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, May 09, 2016 at 02:13:55PM +0200, Takashi Iwai wrote:
> On Wed, 04 May 2016 15:59:06 +0200,
> Charles Keepax wrote:
> > 
> > We return negative values from the file_operations poll callback
> > in a few places, this callback returns an unsigned int and is
> > expected to only return the poll specific flags. This series
> > fixes up these issues and makes a couple of small tidy ups to the
> > code around the edges of those functions.
> > 
> > I noticed this issue whilst doing some additional testing on my
> > propagation of compressed stream error series, but I decided to
> > push these up separately as it is worth getting the fixes in
> > now and not tying them up with that patch chain which is taking
> > longer to get merged.  Also I included the first patch of that
> > chain (Replace complex if statement with switch) because it is a
> > trivial tidy up and might as well get merged now as well.
> 
> Patches 2, 3 and 4 miss Vinod's ack.  Vinod, are you OK with them?

Yup, they look good to me so:

Acked-by: Vinod Koul <vinod.koul@intel.com>

Thanks
-- 
~Vinod
