From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: Re: Does anyone really have success experience with
 SPI codecs with new name-based SOC API?
Date: Mon, 22 Nov 2010 02:01:10 +0000
Message-ID: <1290391270.9850.3.camel@dplaptop.localdomain>
References: <1290079866.1496.55.camel@r60e>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7AC851037E3
	for <alsa-devel@alsa-project.org>; Mon, 22 Nov 2010 03:01:17 +0100 (CET)
In-Reply-To: <1290079866.1496.55.camel@r60e>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexander <subaparts@yandex.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2010-11-18 at 14:31 +0300, Alexander wrote:
> Does anyone really have success experience with SPI codecs with new
> name-based SOC API?
> There are really few SPI codecs in ASoC subsystem, so I wonder if only I
> cannot bind my SPI codec to machine driver.

Just use the registered codec name in the machine driver so soc-core can
match it correctly.  You should not worry about incompatibilities in the
naming convention between SPI registered devices and I2C ones.  The only
thing that we try to guarantee is to be able to uniquely identify the
devices on the system.

Thanks,
Dimitrios
