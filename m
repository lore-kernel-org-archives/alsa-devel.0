From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] Add Palm support to Mainstone
	accelerated touch
Date: Fri, 17 Jul 2009 11:22:18 +0100
Message-ID: <20090717102217.GE3439@rakim.wolfsonmicro.main>
References: <200907171000.24408.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1A08C1038C6
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Jul 2009 12:22:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200907171000.24408.marek.vasut@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 17, 2009 at 10:00:24AM +0200, Marek Vasut wrote:
> From f32fa9ef6476be0cf8106bc57a98724c48d4baa1 Mon Sep 17 00:00:00 2001                                
> From: Marek Vasut <marek.vasut@gmail.com>                                                             
> Date: Fri, 17 Jul 2009 09:54:13 +0200                                                                 
> Subject: [PATCH 1/2] Add Palm support to Mainstone accelerated touch                                  
> 
> This patch refactors the Mainstone accelerated touch code a little and
> adds support for interrupt driven touchscreen on Palm LifeDrive, TX and
> Tungsten T5.                                                           
> 
> Signed-off-by: Marek Vasut <marek.vasut@gmail.com>

The code looks OK but it looks like your mailer has damaged the patch
rather badly - it appears to be padded with whitespace to 80 columns.
When you resend for this please just remove the version number from the
driver, it's not needed now the code is in mainline.

You've also submitted to the wrong subsystem, this patch is for the
input subsystem so should go to Dmitry and linux-input (CC me).
