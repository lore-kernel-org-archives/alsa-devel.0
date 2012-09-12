From: Eric Millbrandt <emillbrandt@dekaresearch.com>
Subject: Re: [PATCH 2/5] ASoC: fsl: mpc5200 combine
	psc_dma	platform data
Date: Wed, 12 Sep 2012 13:15:05 -0400
Message-ID: <0A40042D85E7C84DB443060EC44B3FD336D854FEE6@dekaexchange07.deka.local>
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347416089-23393-3-git-send-email-emillbrandt@dekaresearch.com>
 <20120912135412.GF19055@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dekaexchange07.deka.local (mail.dekaresearch.com
 [208.65.175.196])
 by alsa0.perex.cz (Postfix) with ESMTP id E06772616D5
 for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2012 19:15:13 +0200 (CEST)
In-Reply-To: <20120912135412.GF19055@opensource.wolfsonmicro.com>
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

On 2012-09-12 Mark Brown wrote:
> On Tue, Sep 11, 2012 at 10:14:46PM -0400, Eric Millbrandt wrote:
>> The mpc5200_psc_ac97 and mpc5200_psc_i2s modules rely on shared
>> platform data with mpc5200_dma.
>
> This looks good but depends on patch 1 so I can't apply it - if you can
> rebase things so this is patch 1 I'll apply it.

After mulling your comments I see now that not being able to define a snd_soc_ops for an ASoC machine driver would only work for very few boards.  I'll think on it some more and respin the series to be pcm030 specific.

Eric

-DISCLAIMER: an automatically appended disclaimer may follow. By posting-
-to a public e-mail mailing list I hereby grant permission to distribute-
-and copy this message.-



This e-mail and the information, including any attachments, it contains are intended to be a confidential communication only to the person or entity to whom it is addressed and may contain information that is privileged. If the reader of this message is not the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please immediately notify the sender and destroy the original message.

Thank you.

Please consider the environment before printing this email.
