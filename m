From: Ryan Mallon <ryan@bluewatersys.com>
Subject: Re: [PATCH 1/2] ASoC: Add CS4271 codec support
Date: Thu, 07 Oct 2010 13:53:54 +1300
Message-ID: <4CAD1A22.7090306@bluewatersys.com>
References: <4CAD16A5.1090501@bluewatersys.com>
	<20101007004940.GC30751@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hayes.bluewaternz.com (mail.bluewatersys.com [202.124.120.130])
	by alsa0.perex.cz (Postfix) with ESMTP id 69CFE1039CA
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Oct 2010 02:53:26 +0200 (CEST)
In-Reply-To: <20101007004940.GC30751@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexander <subaparts@yandex.ru>, timur@freescale.com, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 10/07/2010 01:49 PM, Mark Brown wrote:
> On Thu, Oct 07, 2010 at 01:39:01PM +1300, Ryan Mallon wrote:
>> From: Alexander Sverdlin <subaparts@yandex.ru>
>>
>> Added support for Cirrus CS4271 codec to ALSA SoC subsystem.
>>
>> Applies on: 2.6.36-rc6
> 

Ugh, I managed to miss Alexander from the CC list :-/. Alexander, can
you please update the patch as detailed below.

~Ryan

> Unfortunately there have been major changes in the ASoC APIs in -next
> for Liam's multi-component work so you'll need to update this before it
> can be applied.  You should always submit code against -next (except for
> bug fixes to be sent to Linus).
> 
> See
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git
> 
> for current code.
> 
> I gave the driver a quick review and it looks really good - it just
> needs to be updated for current APIs.
> 
>> +static const struct snd_kcontrol_new cs4271_snd_controls[] = {
>> +	SOC_DOUBLE_R("Master Playback Volume", CS4271_VOLA, CS4271_VOLB, 0, 0x7F, 1),
> 
> TLV information would be nice but isn't essential.
> 
>> +	SOC_SINGLE("Digital Loopback Switch", CS4271_MODE2, 4, 1, 0),
> 
> This should probably be done as part of DAPM.  Again probably not
> essential.


-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan@bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
