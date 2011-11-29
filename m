From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RESEND] ASoC: cs42l73: Fix clear wrong bits
 in cs42l73_set_dai_fmt
Date: Tue, 29 Nov 2011 11:51:03 +0000
Message-ID: <20111129115103.GJ2851@opensource.wolfsonmicro.com>
References: <1322567258.2456.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 251C6244C5
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 12:51:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1322567258.2456.1.camel@phoenix>
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
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 29, 2011 at 07:47:38PM +0800, Axel Lin wrote:
> What we want is to clear BIT[5:4](PCM_MODE_MASK) and BIT[3](PCM_BIT_ORDER) bits,
> but current code clears BIT[2:0].

Applied, thanks.
