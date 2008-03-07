From: "Alexandre BOUIN" <a.bouin@kerlink.fr>
Subject: Re: ALSACTL wrong restore on ARM9
Date: Fri, 7 Mar 2008 17:33:06 +0100
Message-ID: <45633.2274167382$1204907643@news.gmane.org>
References: <002201c88065$972cb180$c5861480$@bouin@kerlink.fr>	
	<1204903153.6429.38.camel@localhost.localdomain>	
	<002301c88067$e031b540$a0951fc0$@bouin@kerlink.fr>
	<1204904766.6429.50.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from scanner-relay-corvus2.pulsation.fr
	(scanner-relay-corvus2.pulsation.fr [80.74.64.70])
	by alsa0.perex.cz (Postfix) with SMTP id A083B24337
	for <alsa-devel@alsa-project.org>; Fri,  7 Mar 2008 17:33:11 +0100 (CET)
In-Reply-To: <1204904766.6429.50.camel@localhost.localdomain>
Content-Language: fr
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Liam Girdwood' <lg@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> It's possible that your codec drivers register caching is borked. This
> can be easily confirmed with debug in your driver kcontrol code.

Could you detail what you mean ?
One thing is sure : I've always used directly amixer controls and controls
values are correctly set.
Thus, these wrong values are constant for each control (for one control, the
wrong affected value is not random).

> If your driver looks ok, then I'd suggest looking into your alsa-lib
> cross build. There have been some problems with it being incorrectly
> cross compiled for ARM in the past (pls search the list for details).
> Fwiw, I use OpenEmbedded to build ALSA for ARM and I've never ran into
> this issue.

I'm looking for recompile it ...

Thanks.
Alex.
