From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tpa6130a2: Revisit power-up sequence
Date: Mon, 8 Nov 2010 11:36:52 +0000
Message-ID: <20101108113652.GD21834@rakim.wolfsonmicro.main>
References: <1289206677-11886-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 82B402441C
	for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2010 12:36:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1289206677-11886-1-git-send-email-jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 08, 2010 at 10:57:57AM +0200, Jarkko Nikula wrote:
> There are no known problems with current power-up sequence which first sets
> the /shutdown pin high and then enables the supply. However, swap the order
> so that the device is kept in shutdown/reset mode during the supply voltage
> transition since slowly rising voltages can usually cause problems if the
> device is not kept in reset.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
