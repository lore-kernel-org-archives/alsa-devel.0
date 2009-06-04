From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Palm interrupt driven touchscreen driver
Date: Thu, 4 Jun 2009 10:37:37 +0100
Message-ID: <20090604093737.GF6983@rakim.wolfsonmicro.main>
References: <200906032341.03266.marek.vasut@gmail.com>
	<f17812d70906031835u5a650772wedcab94fd6f2ae2d@mail.gmail.com>
	<20090604085407.GB6983@rakim.wolfsonmicro.main>
	<alpine.LNX.2.00.0906041104080.4067@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 67C0A103929
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 11:37:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0906041104080.4067@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Marek Vasut <marek.vasut@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 04, 2009 at 11:09:34AM +0200, Jaroslav Kysela wrote:
> On Thu, 4 Jun 2009, Mark Brown wrote:

>> As I've said a number of times before AC97 does not support platform
>> data and the ALSA guys blocked adding it.

> We're not blocking adding more data to AC97 structures. We just blocked  
> adding new variable when it's not used.

There was a very strong pushback against the idea of adding a void *
to the structure, which is what I'd be looking for.

> In other words - send a driver code using this variable with the variable 
> addition to the ALSA AC97 structure.

IIRC the original posting had something along with it?  As far as
examples go things like drivers/power/wm97xx_battery.c are already in
tree and pretty much ready to use platform data if it became available.
