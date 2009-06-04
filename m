From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] Palm interrupt driven touchscreen driver
Date: Thu, 4 Jun 2009 11:09:34 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906041104080.4067@eeebox2.perex-int.cz>
References: <200906032341.03266.marek.vasut@gmail.com>
	<f17812d70906031835u5a650772wedcab94fd6f2ae2d@mail.gmail.com>
	<20090604085407.GB6983@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7ACCF103911
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Jun 2009 11:09:35 +0200 (CEST)
In-Reply-To: <20090604085407.GB6983@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Marek Vasut <marek.vasut@gmail.com>, ALSA development <alsa-devel@alsa-project.org>, Eric Miao <eric.y.miao@gmail.com>, linux-arm-kernel@lists.arm.linux.org.uk, Russell King - ARM Linux <linux@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 4 Jun 2009, Mark Brown wrote:

>> to come up with a platform_data to cover the difference of boards
>> and make this driver generic.
>
> As I've said a number of times before AC97 does not support platform
> data and the ALSA guys blocked adding it.

We're not blocking adding more data to AC97 structures. We just blocked 
adding new variable when it's not used.

In other words - send a driver code using this variable with the variable 
addition to the ALSA AC97 structure.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
