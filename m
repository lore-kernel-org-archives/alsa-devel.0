From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: max98088 codec: Catch driver
 bugs for eq channel name
Date: Tue, 4 Oct 2011 12:05:45 +0100
Message-ID: <20111004110545.GI3250@opensource.wolfsonmicro.com>
References: <1317682541-28494-1-git-send-email-rmallon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7DC6824601
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Oct 2011 13:05:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1317682541-28494-1-git-send-email-rmallon@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ryan Mallon <rmallon@gmail.com>
Cc: alsa-devel@alsa-project.org, hidave.darkstar@gmail.com, linux-kernel@vger.kernel.org, lrg@ti.com, peter.hsiang@maxim-ic.com, axel.lin@gmail.com, jesse.marroquin@maxim-ic.com
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 04, 2011 at 09:55:40AM +1100, Ryan Mallon wrote:
> Move the EQ channel names to a separate array and iterate over it in
> max98088_get_channel rather than duplicating the hardcoded channel
> names. Add an error message if an invalid channel is passed and check
> the error in the callers.

Applied both, thanks.
