From: Timur Tabi <timur@freescale.com>
Subject: Re: Embedded I2S / 192khz
Date: Thu, 08 May 2008 09:56:39 -0500
Message-ID: <482314A7.4030502@freescale.com>
References: <76366b180805080650p615851afi272602115ca1660a@mail.gmail.com>
	<20080508140856.GC23041@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 34130245C3
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 16:56:48 +0200 (CEST)
In-Reply-To: <20080508140856.GC23041@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrew Paprocki <andrew@ishiboo.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:

> The PowerPC code in sound/soc/fsl (as of 2.6.25) supports up to 192kHz,
> though it appears to require the codec to clock the bus. 

That's only because the reference board I based the code on uses the codec as
the clock master.  If someone wants to make a board with an 8610 as the clock
master, I'd be happy to update the driver to support that.

-- 
Timur Tabi
Linux kernel developer at Freescale
