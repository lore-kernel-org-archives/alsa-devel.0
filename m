From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/3] ALSA: compress_core: Split copy
	into	seperate read and write callbacks
Date: Fri, 5 Apr 2013 09:23:45 +0100
Message-ID: <20130405082344.GA20026@opensource.wolfsonmicro.com>
References: <1364991209-24653-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1364991209-24653-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <515DC015.7040704@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DF488265F5A
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 10:23:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <515DC015.7040704@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, tiwai@suse.de, broonie@opensource.wolfsonmicro.com, lgirdwood@gmail.com, vinod.koul@intel.com
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 04, 2013 at 01:01:57PM -0500, Pierre-Louis Bossart wrote:
> Why not remove the const to make this consistent with the PCM interface?

I had been trying to avoid loosing the const from the write file
operation, however I am happy to just loose this through casting
instead. It is certainly a simpler change I will respin these to
do so.

Charles
