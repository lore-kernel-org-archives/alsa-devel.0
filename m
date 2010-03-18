From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: remove a card from the list,
 if instantiation failed
Date: Thu, 18 Mar 2010 11:12:57 +0000
Message-ID: <20100318111257.GA3080@opensource.wolfsonmicro.com>
References: <Pine.LNX.4.64.1003180818250.4485@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6416B243DA
	for <alsa-devel@alsa-project.org>; Thu, 18 Mar 2010 12:12:57 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1003180818250.4485@axis700.grange>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 18, 2010 at 08:23:33AM +0100, Guennadi Liakhovetski wrote:
> If instantiation of a card failed, we still have to remove it from the 
> card list on unregistration. This fixes an Oops on Migo-R, triggering, 
> when after a failed firmware load attempt the driver modules are removed 
> and re-inserted again.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> 
> Mark, is this more like what you mean?

Yes, it is.  I'll need to apply this and test later when I've got a
chance.
