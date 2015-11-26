From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 09/13] ASoC: The soc card can have
 auxiliary components
Date: Thu, 26 Nov 2015 13:57:37 +0100
Message-ID: <565701C1.9040900@metafoo.de>
References: <cover.1446717205.git.mengdong.lin@linux.intel.com>
 <cb52fae5395aa4e87b193c0846289e183f708042.1446717205.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-194.synserver.de (smtp-out-208.synserver.de
 [212.40.185.208])
 by alsa0.perex.cz (Postfix) with ESMTP id 615012619FB
 for <alsa-devel@alsa-project.org>; Thu, 26 Nov 2015 13:57:41 +0100 (CET)
In-Reply-To: <cb52fae5395aa4e87b193c0846289e183f708042.1446717205.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mengdong.lin@linux.intel.com, alsa-devel@alsa-project.org, broonie@kernel.org
Cc: tiwai@suse.de, mengdong.lin@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, jeeja.kp@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

On 11/05/2015 10:59 AM, mengdong.lin@linux.intel.com wrote:
> From: Mengdong Lin <mengdong.lin@linux.intel.com>
> 
> Machine drivers can set the name of one or more auxiliary components.
> And the ASoC core will find and probe the auxiliary components.
> 
> Machine drivers can use this to specify the components with topology.
> Then when the components are probed, topology info will be loaded to
> the core.

How is this different from the existing aux_devs?
