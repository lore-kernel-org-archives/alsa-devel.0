From: "Alexandre BOUIN" <a.bouin@kerlink.fr>
Subject: Re: ALSACTL wrong restore on ARM9
Date: Mon, 17 Mar 2008 12:37:15 +0100
Message-ID: <23125.8101798177$1205753919@news.gmane.org>
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
	by alsa0.perex.cz (Postfix) with SMTP id 7188224476
	for <alsa-devel@alsa-project.org>; Mon, 17 Mar 2008 12:37:30 +0100 (CET)
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
> 
> If your driver looks ok, then I'd suggest looking into your alsa-lib
> cross build. There have been some problems with it being incorrectly
> cross compiled for ARM in the past (pls search the list for details).
> Fwiw, I use OpenEmbedded to build ALSA for ARM and I've never ran into
> this issue.
> 
> Liam

Thanks Liam, I've find the issue. 
After having learned many things about kcontrols, I've detected that one of
my controls rewrites other ones but should not do it with alsactl.
As this control aim is for debug, and all my other controls are ok, I can
remove it.

alsactl (re)store works fine now ;)

Thanks again.
Alex.
