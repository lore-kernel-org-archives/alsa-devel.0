From: Tim Starling <tstarling@wikimedia.org>
Subject: Re: [PATCH] ALSA: hda: Fix 0 dB for Packard Bell
 models using Conexant CX20549 (Venice)
Date: Mon, 10 May 2010 17:15:51 +1000
Message-ID: <hs8bra$53h$1@dough.gmane.org>
References: <x2n604760771004281507x5464161frd1f09b6cd4c8a7fc@mail.gmail.com>
	<s5hiq72vkt7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 1456C2470D
	for <alsa-devel@alsa-project.org>;
	Mon, 10 May 2010 09:20:08 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1OBNHY-0003EF-7S
	for alsa-devel@alsa-project.org; Mon, 10 May 2010 09:20:04 +0200
Received: from vps2.angtim.com ([74.207.253.152])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 10 May 2010 09:20:04 +0200
Received: from tstarling by vps2.angtim.com with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Mon, 10 May 2010 09:20:04 +0200
In-Reply-To: <s5hiq72vkt7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/05/10 18:01, Takashi Iwai wrote:
> At Wed, 28 Apr 2010 18:07:16 -0400,
> Daniel Chen wrote:
>>
>> Hi,
>>
>> Attached is a patch against sound-2.6 master HEAD (also applicable to
>> 2.6.32.12 and 2.6.33.3) that fixes 0 dB for Packard Bell machines
>> using Conexant CX20549. Without it, sound distorts horribly.
> 
> Thanks, applied now.

Can you please also add vendor ID 0x17aa (Lenovo)? I have the same
problem on my Thinkpad R61. I compiled my kernel with a 0x17aa case
added where Daniel's patch indicates and tested it with dbverify, it
seems to fix the problem.

I can make a patch if you like.

-- Tim Starling
