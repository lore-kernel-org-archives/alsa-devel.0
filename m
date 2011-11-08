From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: wm9081: Fix reading wrong
 register for setting VMID 2*240k
Date: Tue, 8 Nov 2011 15:34:31 +0000
Message-ID: <20111108153431.GB5632@opensource.wolfsonmicro.com>
References: <1320475639.8360.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 66F6F103903
	for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2011 16:34:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1320475639.8360.1.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 05, 2011 at 02:47:19PM +0800, Axel Lin wrote:
> VMID Divider Enable and Select is controlled by BIT[2:1] of WM9081_VMID_CONTROL
> register (04h).
> Current code reads wrong register (WM9081_BIAS_CONTROL_1) for setting
> VMID 2*240k.

Applied, thanks.
