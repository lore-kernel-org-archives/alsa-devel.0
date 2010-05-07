From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/2] ASoC: tpa6130a2: Use the core to set
	the gain limit
Date: Fri, 7 May 2010 16:44:05 +0100
Message-ID: <20100507154405.GD25793@rakim.wolfsonmicro.main>
References: <1273231451-6697-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E4D631038B3
	for <alsa-devel@alsa-project.org>;
	Fri,  7 May 2010 17:44:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1273231451-6697-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, May 07, 2010 at 02:24:09PM +0300, Peter Ujfalusi wrote:
> Hello,
> 
> Core will receive support for limiting the volume on controls, so
> the custom way of doing it in the tpa driver is no longer needed.
> There was also a problem within the tpa driver when custom limit
> has been configured. The second patch fixes that.
> 
> The combination of the snd_soc_limit_volume, and this series works
> really nicely together.

Having discussed with Liam on IRC I've applied these two as well due to
the dependency on the core change.
