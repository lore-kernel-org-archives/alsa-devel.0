From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ALSA: compress_core: Update calc_avail
	to use	cumulative values
Date: Wed, 10 Apr 2013 10:57:02 +0100
Message-ID: <20130410095702.GA24051@opensource.wolfsonmicro.com>
References: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130409110230.GE31193@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 90517265EF5
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2013 12:03:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130409110230.GE31193@intel.com>
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
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 09, 2013 at 04:32:30PM +0530, Vinod Koul wrote:
> On Wed, Apr 03, 2013 at 01:13:27PM +0100, Charles Keepax wrote:
> > The app_pointer is managed locally by the compress core for memory
> > mapped DSPs but for DSPs that are not memory mapped this would have to
> > be manually updated from within the DSP driver itself, which is hardly
> > very idiomatic.
> app pointer means what has been written into DSP buffer, no matter if its memory
> mapped or not. This is updated after .copy returns so if you have been asked to
> copy 100bytes, and return of .copy, app pointer is incremented by 100, so why is
> that not true for you?

Currently though app_pointer is not updated after a copy callback
the cumulative values are updated, but not app_pointer.
app_pointer is only updated in the case were we don't have a copy
callback and the buffer is managed by the compressed core.

I am quite happy to change that or remove this comment from the change
log if we prefer but as it currently stands app_pointer will not
be updated for systems that use a copy callback by the compress
core.

Charles
