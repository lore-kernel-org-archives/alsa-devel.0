From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: snd_pcm_hardware structure
Date: Wed, 23 Jun 2010 19:47:31 +0100
Message-ID: <AANLkTikKqdUo4oUrOKRhoXX4eVySduRElaSb-My0cAcc@mail.gmail.com>
References: <AANLkTilJuFy_Iysklk-nsE_BzPzgHvQpGW0T3uGhulZt@mail.gmail.com>
	<AANLkTin-BgH2HWLIf1gs8Qcfp11F04J-kL1bH7lpkREe@mail.gmail.com>
	<AANLkTikMXLL8D8f-t2Bok_8Hxi9WGwWfrHJA1VN7Pvsk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 42ED6103920
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 20:47:32 +0200 (CEST)
Received: by fxm13 with SMTP id 13so1412252fxm.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 11:47:31 -0700 (PDT)
In-Reply-To: <AANLkTikMXLL8D8f-t2Bok_8Hxi9WGwWfrHJA1VN7Pvsk@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adish Kuvelker <adkuvi@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 23 June 2010 18:57, Adish Kuvelker <adkuvi@gmail.com> wrote:
> Hello James,
> Thanks a lot....Just a typo error for the period_bytes_min and
> period_bytes_max in my mail.....
>
> Now that my FIFO is 64 bytes and if I need an interrupt to the CPU for
> FIFO being half-empty (i.e 32 bytes = 16 16-bit samples), would it be
> right to set the periods_min = periods_max = 32?
>

No. The periods do not create the interrupt.
Your sound hardware has to do the interrupt.
When does you hardware do the interrupt?
