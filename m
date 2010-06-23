From: Adish Kuvelker <adkuvi@gmail.com>
Subject: Re: snd_pcm_hardware structure
Date: Thu, 24 Jun 2010 02:11:50 +0530
Message-ID: <AANLkTikYHtPFWXNMSk4-H5LvbOY7OAT7-DEFMlfl8FXO@mail.gmail.com>
References: <AANLkTilJuFy_Iysklk-nsE_BzPzgHvQpGW0T3uGhulZt@mail.gmail.com>
	<AANLkTin-BgH2HWLIf1gs8Qcfp11F04J-kL1bH7lpkREe@mail.gmail.com>
	<AANLkTikMXLL8D8f-t2Bok_8Hxi9WGwWfrHJA1VN7Pvsk@mail.gmail.com>
	<AANLkTikKqdUo4oUrOKRhoXX4eVySduRElaSb-My0cAcc@mail.gmail.com>
	<AANLkTimPGZniWasarAH17BRuVZ_8_PYPYp9FtZ8LCvhG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) by alsa0.perex.cz (Postfix) with ESMTP id 2E0F1243AA
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 22:41:51 +0200 (CEST)
Received: by vws20 with SMTP id 20so1382066vws.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 13:41:50 -0700 (PDT)
In-Reply-To: <AANLkTimPGZniWasarAH17BRuVZ_8_PYPYp9FtZ8LCvhG@mail.gmail.com>
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

so I am thinking of sound hardware generating an interrupt at the FIFO
having 32-bytes.
In your first reply did you mean that periods_min = periods_max =1
would be the setting correponding to my hardware initializations to
generate an interrupt after 16 16-bit samples having been transferred?
So considering that the FIFO bank is of 64 bytes, what do you think
would be the setting for periods_min and periods_max?

Regards;
Aadish

On Thu, Jun 24, 2010 at 1:56 AM, Adish Kuvelker <adkuvi@gmail.com> wrote:
> yes...I know that my hardware will generate the interrupt and it will
> be at FIFO being half empty.
>
> On Thu, Jun 24, 2010 at 12:17 AM, James Courtier-Dutton
> <james.dutton@gmail.com> wrote:
>> On 23 June 2010 18:57, Adish Kuvelker <adkuvi@gmail.com> wrote:
>>> Hello James,
>>> Thanks a lot....Just a typo error for the period_bytes_min and
>>> period_bytes_max in my mail.....
>>>
>>> Now that my FIFO is 64 bytes and if I need an interrupt to the CPU for
>>> FIFO being half-empty (i.e 32 bytes = 16 16-bit samples), would it be
>>> right to set the periods_min = periods_max = 32?
>>>
>>
>> No. The periods do not create the interrupt.
>> Your sound hardware has to do the interrupt.
>> When does you hardware do the interrupt?
>>
>
