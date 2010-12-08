From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] ASoC: omap: Add hardware constraint
 for HDMI and ABE
Date: Wed, 8 Dec 2010 09:46:46 +0000
Message-ID: <20101208094645.GA16418@rakim.wolfsonmicro.main>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E80@dlee06.ent.ti.com>
	<201012071057.24139.peter.ujfalusi@nokia.com>
	<201012081111.40323.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DDAF7243E9
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 10:46:47 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <201012081111.40323.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "ext Olaya, Margarita" <magi.olaya@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 08, 2010 at 11:11:40AM +0200, Peter Ujfalusi wrote:

> Since this is ABE/HDMI specific constraint, I would add this from the 
> corresponding codec driver rather than setting this for all McBSP ports 
> regardless if it is used with HDMI or not.

Can the ABE support route changes while a stream is active?
