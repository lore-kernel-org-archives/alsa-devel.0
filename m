From: Adish Kuvelker <adkuvi@gmail.com>
Subject: Re: snd_pcm_hardware structure
Date: Thu, 24 Jun 2010 03:29:40 +0530
Message-ID: <AANLkTimxK2e9ZbfSWRblUng0OCaz_9d7183ucYcvrKRT@mail.gmail.com>
References: <AANLkTilJuFy_Iysklk-nsE_BzPzgHvQpGW0T3uGhulZt@mail.gmail.com>
	<AANLkTin-BgH2HWLIf1gs8Qcfp11F04J-kL1bH7lpkREe@mail.gmail.com>
	<AANLkTikMXLL8D8f-t2Bok_8Hxi9WGwWfrHJA1VN7Pvsk@mail.gmail.com>
	<AANLkTikKqdUo4oUrOKRhoXX4eVySduRElaSb-My0cAcc@mail.gmail.com>
	<AANLkTimPGZniWasarAH17BRuVZ_8_PYPYp9FtZ8LCvhG@mail.gmail.com>
	<AANLkTikK-IxJlnnfUQOLOPi3lvPe_79skqnzn_2aUo6e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C1919243F6
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 23:59:43 +0200 (CEST)
Received: by gyd10 with SMTP id 10so4160377gyd.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 14:59:42 -0700 (PDT)
In-Reply-To: <AANLkTikK-IxJlnnfUQOLOPi3lvPe_79skqnzn_2aUo6e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: James Courtier-Dutton <james.dutton@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks a lot James

Regards;
Aadish

On Thu, Jun 24, 2010 at 2:43 AM, James Courtier-Dutton
<james.dutton@gmail.com> wrote:
> On 23 June 2010 21:26, Adish Kuvelker <adkuvi@gmail.com> wrote:
>> yes...I know that my hardware will generate the interrupt and it will
>> be at FIFO being half empty.
>>
>
> In that case the full buffer is 64, but you have the following parameters:
> .period_bytes_min = 4,
> .period_bytes_max = 32,
> .periods_min = 2,
> .periods_max = 2
>
> A period is how far through the buffer one goes until an interrupt happens.
> So, if the interrupt happens one each half FIFO, one has two periods per buffer.
>
> Kind Regards
>
> James
>
