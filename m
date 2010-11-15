From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCHv2.1] ASoC: Add optional name_prefix for
 codec kcontrol, widget and route names
Date: Mon, 15 Nov 2010 15:24:18 +0000
Message-ID: <20101115152417.GF12986@rakim.wolfsonmicro.main>
References: <1289565525-30231-1-git-send-email-jhnikula@gmail.com>
	<1289673644-2493-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6FB2B244B0
	for <alsa-devel@alsa-project.org>; Mon, 15 Nov 2010 16:24:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1289673644-2493-1-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Nov 13, 2010 at 08:40:44PM +0200, Jarkko Nikula wrote:
> There is a need to prefix codec kcontrol, widget and internal route names in
> an ASoC machine that has multiple codecs with conflicting names. The name
> collision would occur when codec drivers try to registering kcontrols with
> the same name or when building audio paths.

Applied, thanks.
