From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [patch 0/5] kirkwood openrd client audio support -
	v3
Date: Wed, 26 May 2010 00:18:32 +0100
Message-ID: <20100525231831.GA11785@sirena.org.uk>
References: <20100525122236.841941526@mandriva.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D26C245A2
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 01:18:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20100525122236.841941526@mandriva.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: apatard@mandriva.com
Cc: alsa-devel@alsa-project.org, nico@fluxnic.net, saeed@marvell.com, tbm@cyrius.com, linux-arm-kernel@lists.infradead.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Tue, May 25, 2010 at 02:22:36PM +0200, apatard@mandriva.com wrote:

> It's a new try to get merged kirkwood openrd client support.

> The changes are :
> - set window configuration according to dma address
> - namespaced all cs42l51 #define
> - modified cs42l51_dac_names array according to what proposed Mark Brown
> - use SOC_DOUBLE_TLV for mic boost

This looks mostly OK to me - I had a few comments on the CODEC driver
but they're fairly minor.  It'd be good to get some input from the
Kirkwood guys, particularly with regard to the merge path here.
