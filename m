From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 04/16] ASoC: multi-component - TI CODECs
Date: Wed, 30 Jun 2010 13:53:43 +0100
Message-ID: <20100630125342.GA3634@rakim.wolfsonmicro.main>
References: <1277488383-31287-1-git-send-email-lrg@slimlogic.co.uk>
	<1277488383-31287-5-git-send-email-lrg@slimlogic.co.uk>
	<C358A26273CF2948B8BCDBA661A581782A6FBF945E@NOK-EUMSG-03.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A9FD92414C
	for <alsa-devel@alsa-project.org>;
	Wed, 30 Jun 2010 14:53:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <C358A26273CF2948B8BCDBA661A581782A6FBF945E@NOK-EUMSG-03.mgdnok.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: peter.ujfalusi@nokia.com
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 30, 2010 at 02:08:11PM +0200, peter.ujfalusi@nokia.com wrote:
> Is the support for the former codec->idle_bias_off is gone? This patch removes it from the
> tlv320dac33, and t2l4030 codec drivers.

No, that is still present - it's an error in the conversion (probably
caused by forward porting changes from prior to the update I guess).
