From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ALSA: compress_core: Update	calc_avail
	to use cumulative values
Date: Wed, 10 Apr 2013 11:01:04 +0100
Message-ID: <20130410100104.GB24051@opensource.wolfsonmicro.com>
References: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <515DC4E3.7040005@linux.intel.com>
 <20130405083604.GB20026@opensource.wolfsonmicro.com>
 <515EE4DC.6050005@linux.intel.com>
 <20130405151845.GC20026@opensource.wolfsonmicro.com>
 <20130409105505.GD31193@intel.com> <5164E3B4.5050900@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F196E265EF5
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2013 12:01:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5164E3B4.5050900@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Vinod Koul <vinod.koul@intel.com>, patches@opensource.wolfsonmicro.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.jf.intel.com>, lgirdwood@gmail.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 09, 2013 at 08:59:48PM -0700, Pierre-Louis Bossart wrote:
> the question was whether we need these offsets at all. Can't we just use  
> cumulative values everywhere?
> -Pierre
>

Removing them does introduce a modulus operation which is not
very nice given we are dealing with all 64-bit values. Although
limiting the buffer size to 32-bit would make that slightly
neater.

Aside from that the change is trivial to make and does match how
the PCM interface is handled.

Charles
