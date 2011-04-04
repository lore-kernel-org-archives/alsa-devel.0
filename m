From: =?GB2312?B?uN/N8sH6?= <gaowanlong@gmail.com>
Subject: Re: linux-next: Tree for April 4 (sound/soc)
Date: Tue, 5 Apr 2011 00:05:43 +0800
Message-ID: <BANLkTim6uL6ui24fNRwhYsBDX-zFhOBNgg@mail.gmail.com>
References: <20110404143546.e2bb3379.sfr@canb.auug.org.au>
	<20110404083747.34ed1398.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20110404083747.34ed1398.randy.dunlap@oracle.com>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

It seems like that you can't say n with the CONFIG_I2C

2011/4/4, Randy Dunlap <randy.dunlap@oracle.com>:
> On Mon, 4 Apr 2011 14:35:46 +1000 Stephen Rothwell wrote:
>
>> Hi all,
>>
>> Changes since 20110401:
>
>
> When CONFIG_SPI=n, CONFIG_I2C=n:
>
> sound/soc/soc-cache.c:418: error: implicit declaration of function
> 'i2c_master_send'
> sound/soc/soc-cache.c:421: error: implicit declaration of function
> 'do_spi_write'
>
> ---
> ~Randy
> *** Remember to use Documentation/SubmitChecklist when testing your code ***
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
