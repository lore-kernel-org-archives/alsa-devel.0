From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: 20K1 PCI bars, and mode switching info.
Date: Mon, 20 Oct 2008 19:34:39 +0100
Message-ID: <48FCCF3F.3090304@superbug.co.uk>
References: <48FB5B2C.3030008@superbug.co.uk> <s5hwsg3pude.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-37.mail.demon.net (anchor-post-37.mail.demon.net
	[194.217.242.87])
	by alsa0.perex.cz (Postfix) with ESMTP id D5636245E2
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Oct 2008 20:35:02 +0200 (CEST)
In-Reply-To: <s5hwsg3pude.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Sun, 19 Oct 2008 17:07:08 +0100,
> James Courtier-Dutton wrote:
>> This info should help the current snd-sbxfi driver to actually work with
>> the "Vista compatible" cards that it currently does not work with.
>> I believe the true UAA to 20K1 mode switch code is missing from the
>> current alsa snd-sbxfi driver.
> 
> The code to switch to 20k1 mode is already there.
> The sbxfi driver uses ioport for the access, and it looks like in BAR5
> for UAA boards.  This could be the problem...
> 

Well I cannot find it. I can only find:
static void sbxfi_switch_xfi_mode(struct sbxfi *chip)
and that does not do the job.

You need to do this:

>> 2) UAA/20K1 MODE CHANGE (controls who the bus master is):
>> The "Mode Change" register is located in the UAA configuration space at
>> location offset 0x3FFC. This location stores 4 values in a ring.
>> To switch from 20K1 mode to UAA mode write each DW value: CTLA, CTLZ,
>> CTLL, CTLA.
>> To switch from UAA mode to 20K1 mode write each DW value: CTLX, CTL-,
>> CTLF, CTLi
>> To read the current mode, the 4 value ring may be in any position, so
>> one might read for example:
>> CTLL, CTLA, CTLA, CTLZ
>>
>> At power on, the card is in UAA mode.
>> In UAA mode, the UAA chip is the bus master.
>> In 20K1 mode, the 20K1 chip is the bus master.
>> Under either UAA mode or 20K1 mode, the driver can read and write the
>> configuration space of both UAA chip and 20K1 chip.
>>
