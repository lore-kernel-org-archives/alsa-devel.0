From: Adish Kuvelker <adkuvi@gmail.com>
Subject: Re: snd_pcm_hardware structure
Date: Wed, 23 Jun 2010 23:27:36 +0530
Message-ID: <AANLkTikMXLL8D8f-t2Bok_8Hxi9WGwWfrHJA1VN7Pvsk@mail.gmail.com>
References: <AANLkTilJuFy_Iysklk-nsE_BzPzgHvQpGW0T3uGhulZt@mail.gmail.com>
	<AANLkTin-BgH2HWLIf1gs8Qcfp11F04J-kL1bH7lpkREe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CD95D103809
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Jun 2010 19:57:38 +0200 (CEST)
Received: by gyd10 with SMTP id 10so3947336gyd.38
	for <alsa-devel@alsa-project.org>; Wed, 23 Jun 2010 10:57:37 -0700 (PDT)
In-Reply-To: <AANLkTin-BgH2HWLIf1gs8Qcfp11F04J-kL1bH7lpkREe@mail.gmail.com>
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

Hello James,
Thanks a lot....Just a typo error for the period_bytes_min and
period_bytes_max in my mail.....

Now that my FIFO is 64 bytes and if I need an interrupt to the CPU for
FIFO being half-empty (i.e 32 bytes = 16 16-bit samples), would it be
right to set the periods_min = periods_max = 32?

Regards,
Aadish

On Wed, Jun 23, 2010 at 11:15 PM, James Courtier-Dutton
<james.dutton@gmail.com> wrote:
> On 23 June 2010 18:22, Adish Kuvelker <adkuvi@gmail.com> wrote:
>> Hello,
>>
>> I am developing a ALSA driver for the AtlasIII AC'97 Controller. The
>> AC'97 Controller FIFO is arranged as 16 32-bit entries. My PCM data
>> would be 16-bit samples and the driver will cater to 2-front channel
>> audio. I have configured the snd_pcm_hardware members as follows:
>> .formats = SNDDRV_PCM_FMTBIT_S16_LE
>> .period_bytes_max = 4,
>> .period_bytes_min = 64,
>> As I would need a minimum of 4-byte sample to be transferred and the
>> "period_bytes_max" value has been set considering the maximum size of
>> the FIFO in bytes. Is my understanding correct in doing these
>> settings?
>>
>> Secondly, I am having slight problems in understanding the
>> "snd_pcm_hardware" members periods_min and periods_max. Can anyone
>> throw some more light on this in addition to what is explained in the
>> "Writing an Audio Driver"?
>>
>
> max should = 64
> min should = 4
>
> periods_min and periods_max is dependent on when the sound card
> interrupts the CPU.
> So, if the CPU gets an interrupt once every 16 samples, then
> periods_min = periods_max = 1
> If the sound card does not interrupt the CPU at all, you have to
> provide a method to notify the CPU when to next fill the FIFO.
>
