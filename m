From: Adish Kuvelker <adkuvi@gmail.com>
Subject: Re: snd_pcm_hardware structure
Date: Thu, 24 Jun 2010 01:56:40 +0530
Message-ID: <AANLkTimPGZniWasarAH17BRuVZ_8_PYPYp9FtZ8LCvhG@mail.gmail.com>
References: <AANLkTilJuFy_Iysklk-nsE_BzPzgHvQpGW0T3uGhulZt@mail.gmail.com>
	<AANLkTin-BgH2HWLIf1gs8Qcfp11F04J-kL1bH7lpkREe@mail.gmail.com>
	<AANLkTikMXLL8D8f-t2Bok_8Hxi9WGwWfrHJA1VN7Pvsk@mail.gmail.com>
	<AANLkTikKqdUo4oUrOKRhoXX4eVySduRElaSb-My0cAcc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 52B1824390
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 22:26:42 +0200 (CEST)
Received: by vws20 with SMTP id 20so1365815vws.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 13:26:41 -0700 (PDT)
In-Reply-To: <AANLkTikKqdUo4oUrOKRhoXX4eVySduRElaSb-My0cAcc@mail.gmail.com>
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

yes...I know that my hardware will generate the interrupt and it will
be at FIFO being half empty.

On Thu, Jun 24, 2010 at 12:17 AM, James Courtier-Dutton
<james.dutton@gmail.com> wrote:
> On 23 June 2010 18:57, Adish Kuvelker <adkuvi@gmail.com> wrote:
>> Hello James,
>> Thanks a lot....Just a typo error for the period_bytes_min and
>> period_bytes_max in my mail.....
>>
>> Now that my FIFO is 64 bytes and if I need an interrupt to the CPU for
>> FIFO being half-empty (i.e 32 bytes = 16 16-bit samples), would it be
>> right to set the periods_min = periods_max = 32?
>>
>
> No. The periods do not create the interrupt.
> Your sound hardware has to do the interrupt.
> When does you hardware do the interrupt?
>
