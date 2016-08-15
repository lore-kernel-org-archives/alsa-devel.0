From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 00/17] Baytrail audio fixes
Date: Mon, 15 Aug 2016 09:56:31 -0500
Message-ID: <928a31f5-d032-c06c-f59d-04d0d7ef1220@linux.intel.com>
References: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 0066E2666DB
 for <alsa-devel@alsa-project.org>; Mon, 15 Aug 2016 16:56:36 +0200 (CEST)
In-Reply-To: <1471037280-17433-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, irina.tirdea@intel.com
List-Id: alsa-devel@alsa-project.org

Thanks Mark for applying the patches on your topic/intel branch.
I was planning to send a quick update to fix the two warnings reported 
by ktest, will send this asap. I also have a set of typos and quirks for 
new platforms reported directly to me.

While I am at it, I see all the patches applied except "[PATCH 13/17] 
clk: x86: Add Atom PMC platform clocks". if we enable the MCLK for 
existing platforms but delay the MCLK support we probably break 
something. how do we go about this? should this go through the clock 
subsystem? I am not aware of any other users of these platform clocks so 
the impact on other subsystems should be zero.
