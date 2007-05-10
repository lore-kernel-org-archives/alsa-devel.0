From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Sound on SMDK2410
Date: Thu, 10 May 2007 15:50:24 +0100
Message-ID: <1178808624.10518.106.camel@a10072.wolfsonmicro.main>
References: <AC2729D6E3A3314A922E4E0FBE513F65CE331E@MAIL.eldorado.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (unknown [80.75.67.54])
	by alsa0.perex.cz (Postfix) with ESMTP id E16C824398
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2007 16:50:25 +0200 (CEST)
In-Reply-To: <AC2729D6E3A3314A922E4E0FBE513F65CE331E@MAIL.eldorado.org.br>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jose Henrique Spahn Torres <jose.torres@eldorado.org.br>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2007-05-10 at 11:36 -0300, Jose Henrique Spahn Torres wrote:
> Hi all,
> 
> I am trying to get sound working on a SMDK-2410 evaluation board.
> I compiled kernel 2.6.20 with alsa-driver-1.0.14rc4. However, I could
> not find the specific uda-1341TS driver for this board.

The uda1341 codec driver (from sound/i2c/l3/uda1341.c) needs some
changes before it will work under ASoC and S3C24xx. L3 support will also
have to be added to the S3C24xx platform before this driver will work. 

> I would like to know the status of this driver, if there will be one
> some time soon.
> 

Afaik, nobody is working on this codec. Please feel free to make the
necessary changes and submit a patch.

Thanks

Liam
