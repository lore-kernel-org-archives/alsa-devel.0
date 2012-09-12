From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH 1/5] ASoC: fsl: mpc5200 multi-codec fixups
Date: Wed, 12 Sep 2012 10:29:38 -0400
Message-ID: <0A40042D85E7C84DB443060EC44B3FD336D854FEE4@dekaexchange07.deka.local>
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347416089-23393-2-git-send-email-emillbrandt@dekaresearch.com>
 <20120912030457.GF9162@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
 [208.65.175.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 754A42616CF
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 16:29:45 +0200 (CEST)
In-Reply-To: <20120912030457.GF9162@opensource.wolfsonmicro.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: 'Mark Brown' <broonie@opensource.wolfsonmicro.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Anatolij Gustschin <agust@denx.de>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 2012-09-11 Mark Brown wrote:
>> --- a/arch/powerpc/platforms/52xx/Kconfig
>> +++ b/arch/powerpc/platforms/52xx/Kconfig
>> @@ -1,6 +1,7 @@
>>  config PPC_MPC52xx  bool "52xx-based boards"        depends on 6xx +        select
>>  FSL_SOC     select PPC_CLOCK        select PPC_PCI_CHOICE
>
> This doesnt seem to have much to do with the commit message...
>
I'll spit this into another patch.  SND_POWERPC_SOC, which wraps all of the Powerpc socs, depends on FSL_SOC.  Would it be better to have SND_POWERPC_SOC depend on FSL_SOC or PPC_MPC52xx?

>> -/* ALSA only supports a single AC97 device so static is recommend here
>> */ +/* ALSA only supports a single AC97 bus device so static is
>> recommend +here */
>>  static struct psc_dma *psc_dma;
>
> Or this.
>
I'll also be split this out.  The change was to clarify that now you can have multiple ac97 codec, but soc-core can still only have on ac97 bus.

Eric




This e-mail and the information, including any attachments, it contains are intended to be a confidential communication only to the person or entity to whom it is addressed and may contain information that is privileged. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
