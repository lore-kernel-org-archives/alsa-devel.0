From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] add channel order setting interface in
	asoc core
Date: Fri, 11 Sep 2009 11:25:56 +0100
Message-ID: <20090911102556.GB15479@rakim.wolfsonmicro.main>
References: <1252659822-12915-1-git-send-email-21cnbao@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 17E1C24621
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Sep 2009 12:25:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1252659822-12915-1-git-send-email-21cnbao@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Barry Song <21cnbao@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 11, 2009 at 05:03:42PM +0800, Barry Song wrote:

> As discussed, I am adding a patch to add an interface to set the
> relationship between audio channel No. and slot No.
> The interface should be really useful because nobody can ensure
> audio channel n always uses slot n in all platforms. And for some
> devices, the relationship even can change with sound mode switch
> in 2.1,3.1,4.1,5.1,6.1,7.1.
> After the patch is applied, I can change bfin stuff based on it.

This is the right idea but some updates would be nice:

>  /**
> + * snd_soc_dai_set_channel_order - configure DAI audio channel order

Please rename to snd_soc_dai_set_channel_map.

> + * @dai: DAI
> + * @num: how many channels
> + * @slot: pointer to an array which imply the slot number channel 0~num-1 uses
> + *
> + * configure the relationship between channel number and TDM slot number.

I'd say something line

   'Pointer to an array of data sources.  Each element specifies the
    data slot in the source data which will be used for that slot index
    in the output data.'

It'd also be better if the API separate transmit and receive mappings -
having separate tx_num, tx_slot and rx_num, rx_slot should do the trick.
