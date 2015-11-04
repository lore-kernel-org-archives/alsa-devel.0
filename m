From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Wed, 4 Nov 2015 22:48:40 +0100
Message-ID: <563A7D38.3010708@tekno-soft.it>
References: <CAG5mAdxYEL22o=9AKQefb-vkf8KATEojH0qgPWzfAim+5fm5vQ@mail.gmail.com>
 <5634870A.4080206@tekno-soft.it>
 <CAG5mAdwUMd5q3fKBv6_1Laag7vij19ZjeOcZzm-ZzLH0E6QjKA@mail.gmail.com>
 <563A253C.7080709@tekno-soft.it> <20151104175815.GB3794@Asurada-CZ80>
 <563A49CA.8090501@tekno-soft.it> <20151104181821.GB4057@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tekno-soft.it (li153-180.members.linode.com
 [109.74.206.180])
 by alsa0.perex.cz (Postfix) with ESMTP id CA98926073E
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 22:48:55 +0100 (CET)
In-Reply-To: <20151104181821.GB4057@Asurada-CZ80>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Caleb Crome <caleb@crome.org>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 11/04/2015 07:18 PM, Nicolin Chen wrote:
> On Wed, Nov 04, 2015 at 07:09:14PM +0100, Roberto Fichera wrote:
>
>> I can try to increase the FIFO watermark up to 15 elements, but after that
>> I don't have more choices. The problem is that the TDM has to run continuously
>> because the SLIC need it. I can eventually enable and disable the DMA requests
>> depending by the active channels for optimization, but the problem still,why the
>> DMA transfer is not triggered?
>  
> There's nothing you can do from SSI side. If you don't clear the
> Channel Error bit, the channel might be still hanging there until
> you clear the bit or reset the channel. You may read SDMA chapter
> for details.

Ok! Will have a look tomorrow morning.
