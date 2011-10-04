From: Vinod Koul <vinod.koul@linux.intel.com>
Subject: Re: [PATCH] ASoC: Remove needless
 codec->dapm.bias_level assignment to SND_SOC_BIAS_OFF
Date: Tue, 04 Oct 2011 10:27:43 +0530
Message-ID: <1317704263.1573.2206.camel@vkoul-udesk3>
References: <1317644236.2724.1.camel@phoenix>
	<20111003131832.GL3731@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E5FD244C8
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 07:04:22 +0200 (CEST)
In-Reply-To: <20111003131832.GL3731@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Axel Lin <axel.lin@gmail.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-10-03 at 14:18 +0100, Mark Brown wrote:
> On Mon, Oct 03, 2011 at 08:17:16PM +0800, Axel Lin wrote:
> > This assignment is done by the snd_soc_register_codec so there is no need
> > to redo it in probe function of a codec driver.
> 
> Axel, please stop CCing Harsha Priya on patches - you should've
> noticed that his address bounces by now.
Hmmm, i can send a patch to update her email id. But for now i dont
think she will work on kernel

-- 
~Vinod
