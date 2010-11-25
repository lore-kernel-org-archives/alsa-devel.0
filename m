From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x - fix variable may be
 used uninitialized warning
Date: Thu, 25 Nov 2010 21:47:41 +0000
Message-ID: <20101125214741.GB26792@opensource.wolfsonmicro.com>
References: <1290609659.2749.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82284103C7E
	for <alsa-devel@alsa-project.org>; Thu, 25 Nov 2010 22:47:32 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1290609659.2749.2.camel@phoenix>
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
Cc: vbarinov@embeddedalley.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 24, 2010 at 10:40:59PM +0800, Axel Lin wrote:
> If aic3x_read failed , val is used uninitialized.
> Fix it by initializing val to 0.

I applied this one too after Liam's ack (via IM), thanks.
