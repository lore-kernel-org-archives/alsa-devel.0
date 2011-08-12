From: Barry Song <21cnbao@gmail.com>
Subject: Re: [uclinux-dist-devel] [PATCH 3.0]ASoC: ad193x: add
 spi_hw_read, fix sysclk and register definition
Date: Fri, 12 Aug 2011 10:42:35 +0800
Message-ID: <CAGsJ_4we2uAP6osxQ+NrwbK=e1oR0uyyR=sFgtHQNuhFRF0pHg@mail.gmail.com>
References: <CAHG8p1B2HB61yooEsPwzw+4E60ffM2NUsb98yCsanfPnWD9vgA@mail.gmail.com>
	<DB904C5425BA6F4E8424B3B51A1414D16CA93F826F@NWD2CMBX1.ad.analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DAE89103967
	for <alsa-devel@alsa-project.org>;
	Fri, 12 Aug 2011 04:42:55 +0200 (CEST)
Received: by bkar19 with SMTP id r19so1395455bka.38
	for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2011 19:42:55 -0700 (PDT)
In-Reply-To: <DB904C5425BA6F4E8424B3B51A1414D16CA93F826F@NWD2CMBX1.ad.analog.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Zhang, Sonic" <Sonic.Zhang@analog.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Scott Jiang <scott.jiang.linux@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "stable@kernel.org" <stable@kernel.org>, "uclinux-dist-devel@blackfin.uclinux.org" <uclinux-dist-devel@blackfin.uclinux.org>
List-Id: alsa-devel@alsa-project.org

>>Subject: [uclinux-dist-devel] [alsa-devel][PATCH 3.0]ASoC:
>>ad193x: add spi_hw_read, fix sysclk and register definition
>>
>>asoc cache layer can't support this kind of spi registers, so
>>bypass cache and read regiters directly
>>
>
> This patch is against stable kernel 3.0 only, the ASOC framework in kernel 3.1 and later are different.

this can't be one patch, but be n patches since it is doing n
different work. it is really difficult to understand what the patch is
really doing.

>
> Sonic
>
>>Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>


-barry
