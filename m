From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: looping S/PDIF data
Date: Fri, 20 Jun 2008 21:52:55 +0200
Message-ID: <485C0A97.7020909@keyaccess.nl>
References: <20080531112606.5884a1c9@mjolnir.drzeus.cx>	<20080617215504.3203a5ed@mjolnir.drzeus.cx>	<4858B84B.4030800@keyaccess.nl>	<s5hej6t91u1.wl%tiwai@suse.de>	<Pine.LNX.4.61.0806191435270.1798@tm8103-a.perex-int.cz>	<s5hskv97fqk.wl%tiwai@suse.de>
	<20080620214516.28e9d3f3@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id F375624653
	for <alsa-devel@alsa-project.org>;
	Fri, 20 Jun 2008 21:52:21 +0200 (CEST)
In-Reply-To: <20080620214516.28e9d3f3@mjolnir.drzeus.cx>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre Ossman <drzeus@drzeus.cx>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA devel <alsa-devel@alsa-project.org>, mulix@mulix.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 20-06-08 21:45, Pierre Ossman wrote:

> On Thu, 19 Jun 2008 14:48:19 +0200
> Takashi Iwai <tiwai@suse.de> wrote:
> 
>> At Thu, 19 Jun 2008 14:39:05 +0200 (CEST),
>> Jaroslav Kysela wrote:
>>> I don't think that this patch is correct. DMA transfers should be disabled 
>>> by:
>>>
>>> outl(what, TRID_REG(trident, T4D_STOP_B));
>>> outl(val, TRID_REG(trident, T4D_AINTEN_B));
>> They are already in the trigger callback as long as I saw the code
>> quickly.  So the problem should be somewhere else.
>>
>>> lines. Adding &= ~SPDIF_EN can disable output from AC97 to S/PDIF as well.
>> That's true.
>>
>> Anyway, if you are up now, I'll let you hunt further as you are the
>> author of the driver :)
>>
> 
> Are there any specs on this hardware? I could play around a bit myself,
> but I can't really find any documentation on the registers.

At:

ftp://ftp.alsa-project.org/pub/manuals/trident/

there's a 4D-Wave DX technical reference manual and .doc files which at 
first glance look useful.

Rene.
