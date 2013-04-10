From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ALSA: compress_core: Update calc_avail
	to use	cumulative values
Date: Wed, 10 Apr 2013 11:07:57 +0100
Message-ID: <20130410100757.GC24051@opensource.wolfsonmicro.com>
References: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130409110230.GE31193@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A037265EF5
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2013 12:07:58 +0200 (CEST)
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
> What is this patch based off< certainly not asoc/sound-next as I dont remember
> this comment. IIRC comment was to test this for capture case!

This patch is based off Mark's asoc/for-next tree, apologies I
guess I should have based this of Takashi's for-next tree.
Although I wouldn't have thought they would have differed here as
there haven't been any updates recently appart from the meta-data
stuff.

Charles
