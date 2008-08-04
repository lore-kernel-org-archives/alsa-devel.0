From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH 10/10] wss_lib: use wss detection code
 instead of ad1848 one
Date: Mon, 4 Aug 2008 06:31:37 +0200
Message-ID: <20080804063137.35b03d10.krzysztof.h1@poczta.fm>
References: <20080718215126.7128a6f9.krzysztof.h1@poczta.fm>
	<4883632A.8090106@keyaccess.nl> <4887A28F.90506@keyaccess.nl>
	<20080724072620.4197510c.krzysztof.h1@poczta.fm>
	<4888B993.2040101@keyaccess.nl>
	<20080724204734.0ae77007.krzysztof.h1@poczta.fm>
	<4888D854.40509@keyaccess.nl> <48965F9F.500@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id AD9E824409
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Aug 2008 06:26:13 +0200 (CEST)
In-Reply-To: <48965F9F.500@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 04 Aug 2008 03:47:11 +0200
Rene Herman <rene.herman@keyaccess.nl> wrote:

> On 24-07-08 21:30, Rene Herman wrote:
> 
> >> If you have any of these please post results of your tests.
> > 
> > Will wait for V2 and will do; make take some time. I hope to not have
> > time over the coming weekend...
> 
> Testing results. Only tested playback for now, not capture:
> 

Thank you very much  for testing...
> 
> --- OPTi 92x (snd-opti92x-ad1848, snd-opti92x-cs4231)
> 
> Firstly, snd-opti92x-ad1848 doesn't work for anything anymore. The chip 
> is each time detected as "OPTi 93x" instead of the actual AD/CS chip. 
> Probably minor buglet -- I did not look, just mechanically switched 
> cards and tested.
> 
> snd-opti92x-cs4231 works better:
> 
> OPTi		WSS		/proc/asund/cards		Result
> ---------------------------------------------------------------------
> 924		CS4231A-KL	"OPTi 82C924, CS4231"		Hangs
> 924		AD1845JP	"OPTi 82C924, AD1845"		Hangs
> 925		AD1845JP	"OPTi 82C925, AD1845"		Works
> 928		CS4248-KL	"OPTi 82C928, CS4231"		Works
> 929A		CS4248-KL	"OPTi 82C929, CS4231A"		Works
> 929A		AD1848		"OPTi 82C929, AD1848"		Works
> 929A		AD1845JP	"OPTi 82C929, AD1845"		Works
> 929A		AD1846JP"	"OPTi 82C929, AD1848"		Works
> 
> I've been running with the WSS code for some time locally and will need 
> to recompile a vanilla kernel onto there to check 924. I expect it's not 
> a regression.
> 

I do not have hardware to test this.

> As to your specific question -- CS4248 seems to be detected as CS4231(A)
> 

I'll look into detection code again. I will try to find another detection procedure (as was done for cmi8330).

> 
> --- Crystal CS423x (snd-cs4232, snd-cs4236)
> 
> Chip		/proc/asound/cards		Result
> ------------------------------------------------------
> CS4232		"CS4232"			Works
> CX4235-XQ3	"CS4235"			Silent
> CS4236B-KQ	"CS4236B"			Works
> CX4236B-XQ3	"CS4236B"			Works
> CX4237B-XQ3	"CS4237B"			Works
> CS4239-KQ	"CS4239"			Works
> 
> 
> I believe the CX4235 is simply broken -- everything looks in order, just 
> no signal. Not expected to have anything to do with things.
> 


> 
> --- Aztech Sound Galaxy AZT2320 (snd-azt2320)
> 
> Chip: AZT2320
> 
> Ha, finally... this one looks to be a regression. I have an large stream of:
> 
> ALSA sound/isa/wss/wss_lib.c:229: codec out - reg 0xc = 0x0
> ALSA sound/isa/wss/wss_lib.c:229: codec out - reg 0x0 = 0xaa
> ALSA sound/isa/wss/wss_lib.c:229: codec out - reg 0x1 = 0x45
> ALSA sound/isa/wss/wss_lib.c:229: codec out - reg 0xc = 0x0
> ALSA sound/isa/wss/wss_lib.c:229: codec out - reg 0x0 = 0xaa
> ALSA sound/isa/wss/wss_lib.c:229: codec out - reg 0x1 = 0x45
> 
> before it craps out (doesn't load). I'll look into it unless you beat me 
> to it.
> 

I do not have such a card. The debug code shows that it comes from
the wss detection procedure. You may check if the azt2320 driver
correctly enables access to the wss codec (it looks like the codec
is not accessible or it is very slowww).
 
> --- Aztech Sound Galaxy AZT1605/AZT2316 (local snd-galaxy)
> 
> Aztech		WSS		"Chip"			Result
> --------------------------------------------------------------
> AZT1605		CS4231-KL	To be tested		To be tested
> AZT1605		CS4231A-KL	To be tested		To be tested
> AZT1605		AD1845JP	To be tested		To be tested
> AZT2316A	CS4248-KL	To be tested		To be tested
> AZT2316A	CS4231A-KL	To be tested		To be tested
> AZT2316A	AD1845XP	To be tested		To be tested
> AZT2316R	CS4231A-KL	To be tested		To be tested
> AZT2316-S	CS4231A-KL	To be tested		To be tested
> 
> I'll test these after reviving snd-galaxy. Saw you already tested one as 
> well though.
> 

I tested: AZT2316R + CS4231A-KL (card I38-MMSN852)

Regards,
Krzysztof

----------------------------------------------------------------------
Tanie rozmowy!
Sprawdz >>>  http://link.interia.pl/f1e91
