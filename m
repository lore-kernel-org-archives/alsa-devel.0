From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: omap: rx51: Enable McBSP2 sidetone
Date: Wed, 9 Mar 2011 10:11:59 +0000
Message-ID: <20110309101157.GA1225@sirena.org.uk>
References: <1299662700-25220-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1C40524594
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 11:12:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1299662700-25220-1-git-send-email-jhnikula@gmail.com>
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

On Wed, Mar 09, 2011 at 11:25:00AM +0200, Jarkko Nikula wrote:
> McBSP sidetone is needed in telephony applications. McBSP sidetone is a
> configurable FIR filter that forms a loopback from McBSP input to output.
> This patch enables the McBSP2 sidetone ALSA controls so that it can be used
> on Nokia RX-51/N900.

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
