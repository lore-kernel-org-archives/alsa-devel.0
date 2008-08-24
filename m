From: Travis Place <wishie@wishie.net>
Subject: Re: [PATCH] CA0106 on MSI K8N Diamond PLUS Motherboard
Date: Mon, 25 Aug 2008 05:36:50 +1000
Message-ID: <200808250536.50634.wishie@wishie.net>
References: <200808250535.05985.wishie@wishie.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www.wishie.net (202-137-100-224.dial.usertools.net
	[202.137.100.224])
	by alsa0.perex.cz (Postfix) with ESMTP id 29F3D24133
	for <alsa-devel@alsa-project.org>;
	Sun, 24 Aug 2008 21:36:53 +0200 (CEST)
Received: from laptop.local (unknown [192.168.0.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by www.wishie.net (Postfix) with ESMTP id 855B02FBB4
	for <alsa-devel@alsa-project.org>; Sun, 24 Aug 2008 20:01:18 +1000 (EST)
In-Reply-To: <200808250535.05985.wishie@wishie.net>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Err, not gpio_type .. i meant spi_dac

Travis.


On Monday 25 August 2008 5:35:05 am Travis Place wrote:
> Previously i posted a patch for a new ssid for the onboard ca0106 on the
> K8N Diamond motherboard. Now, it is apparently really called a 'K8N Diamond
> PLUS', and also requires the gpio_type to be changed too.
>
> Attached is a patch for this.
>
> Changelog: Correct a previous patch for the ca0106 onboard the MSI K8N
> Diamond PLUS motherboard. Confirmed to have Line/Mic/Aux working for input,
> and sound output working as expected.
>
> Signed-off-by: Travis Place <wishie@wishie.net>
