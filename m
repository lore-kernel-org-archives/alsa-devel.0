From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 11/13] soundwire: cdns: Add stream
 routines
Date: Fri, 6 Apr 2018 14:27:43 +0530
Message-ID: <20180406085742.GM6014@localhost>
References: <1522946904-2089-1-git-send-email-vinod.koul@intel.com>
 <1522946904-2089-12-git-send-email-vinod.koul@intel.com>
 <03af620f-2961-32f0-99a2-dbf4e5bd0fd2@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 7F0B0266E30
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 10:53:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <03af620f-2961-32f0-99a2-dbf4e5bd0fd2@linux.intel.com>
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
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 05, 2018 at 07:29:11PM -0500, Pierre-Louis Bossart wrote:
> On 4/5/18 11:48 AM, Vinod Koul wrote:

> >+static int cdns_get_pdi(struct sdw_cdns *cdns,
> >+		struct sdw_cdns_pdi *pdi,
> >+		unsigned int num, u32 ch)
> >+{
> >+	int i, pdis = 0;
> >+	u32 ch_count = ch;
> 
> redundant variable without added value...

ok will remove

> >+EXPORT_SYMBOL(sdw_cdns_alloc_stream);
> 
> can you clarify the difference between _get_pdi and _find_pdi and
> alloc_stream/get_stream.
> 
> It's pretty confusing.

Okay will add few notes and try to rename the functions.
-- 
~Vinod
