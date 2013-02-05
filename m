From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3] ASoC: soc-compress: Add support for not
 memory mapped DSPs
Date: Tue, 5 Feb 2013 03:54:50 -0800
Message-ID: <20130205115450.GE3143@intel.com>
References: <1359104400-18527-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20130128040416.GJ26562@intel.com>
 <20130128045609.GA5683@opensource.wolfsonmicro.com>
 <20130128060914.GM26562@intel.com>
 <20130128064440.GB5683@opensource.wolfsonmicro.com>
 <20130128093449.GO26562@intel.com>
 <20130128104910.GB14418@opensource.wolfsonmicro.com>
 <20130129185116.GA27083@opensource.wolfsonmicro.com>
 <20130131030232.GB3143@intel.com>
 <20130205104147.GA22562@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 24E80260304
 for <alsa-devel@alsa-project.org>; Tue,  5 Feb 2013 13:19:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20130205104147.GA22562@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, liam.r.girdwood@intel.com, vinod.koul@linux.jf.intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 05, 2013 at 10:41:47AM +0000, Charles Keepax wrote:
> The ASoC compressed API did not implement the copy callback in its
> compressed ops which is required for DSPs that are not memory mapped.
> 
> This patch creates a local copy of the compress ops for each runtime and
> modifies them with a copy callback as appropriate.
> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Acked-by: Vinod Koul <vinod.koul@intel.com>

--
~Vinod
