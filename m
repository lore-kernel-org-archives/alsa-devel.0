From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2 1/2] ASoC: core: Add flag to ignore
 pmdown_time at pcm_close
Date: Fri, 21 Oct 2011 20:41:31 +0100
Message-ID: <20111021194131.GA2843@opensource.wolfsonmicro.com>
References: <1318592614-13110-1-git-send-email-peter.ujfalusi@ti.com>
	<1318592614-13110-2-git-send-email-peter.ujfalusi@ti.com>
	<12D0C12AF19E15409D57F22566E88EF50A813690AD@bgsmsx501.gar.corp.intel.com>
	<20111021085303.GB3513@opensource.wolfsonmicro.com>
	<12D0C12AF19E15409D57F22566E88EF50A81369249@bgsmsx501.gar.corp.intel.com>
	<20111021091358.GG3513@opensource.wolfsonmicro.com>
	<12D0C12AF19E15409D57F22566E88EF50A813D504E@bgsmsx501.gar.corp.intel.com>
	<3CA6C6D9F70D314CA34352990B57DA1507C8CB95AD@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CE9FF1039A5
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Oct 2011 21:41:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3CA6C6D9F70D314CA34352990B57DA1507C8CB95AD@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nallasellan, Singaravelan" <singaravelan.nallasellan@intel.com>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, "Babu, Ramesh" <ramesh.babu@intel.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 21, 2011 at 10:31:40PM +0530, Nallasellan, Singaravelan wrote:

Fix your mailer to word wrap within paragraphs and don't top post when
posting to public mailing lists.

> I think the requirement is to delay the power down the link during the
> music playback. There is a possibility that next song will start
> playing sooner. In this case, try to avoid power down and power up the
> DAI immediately. In case of voice call, it is not expected to have
> voice call immediately after a call. It can be closed. Phone stack can
> go ahead and close the modem path but codec path will still be open.
> This will cause glitches.

You can't decide this on the basis of the DAI, though - the system
integrator may have thought of another use for the DAI.
