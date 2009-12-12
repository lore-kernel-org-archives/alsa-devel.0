From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Two codecs using the same I2S bus
Date: Sat, 12 Dec 2009 18:06:16 +0000
Message-ID: <20091212180615.GB3092@sirena.org.uk>
References: <4B223B13.8050502@langendorff.nl>
	<20091212180521.GA3092@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E7C6324790
	for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2009 19:06:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091212180521.GA3092@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Niels Langendorff <linux@langendorff.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Dec 12, 2009 at 06:05:22PM +0000, Mark Brown wrote:
> On Fri, Dec 11, 2009 at 01:29:07PM +0100, Niels Langendorff wrote:

> > I there some solution for this and/or example code
> 
> This should work with the kernel as-is providing the two CODECs don't

Oh, and the OMAP-based Pandora board is an example of doing this.
