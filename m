From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Fix null pointer
 dereference when pdata is not set
Date: Mon, 6 Sep 2010 10:45:14 +0100
Message-ID: <20100906094514.GC10367@rakim.wolfsonmicro.main>
References: <1283703022-3730-1-git-send-email-jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 844C3244E7
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Sep 2010 11:45:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1283703022-3730-1-git-send-email-jhnikula@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Jiri Slaby <jirislaby@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, Sep 05, 2010 at 07:10:22PM +0300, Jarkko Nikula wrote:
> Null pointer dereference will occur from *setup = pdata->setup if pdata
> is not set. Fix this by moving assignments from pdata inside non-null case.
> 
> Thanks to Jiri Slaby <jirislaby@gmail.com> for noticing.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Jiri Slaby <jirislaby@gmail.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
