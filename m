From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [PATCH 10/10] wss_lib: use wss detection code
 instead of ad1848 one
Date: Mon, 04 Aug 2008 03:47:11 +0200
Message-ID: <48965F9F.500@keyaccess.nl>
References: <20080718215126.7128a6f9.krzysztof.h1@poczta.fm>	<4883632A.8090106@keyaccess.nl>	<4887A28F.90506@keyaccess.nl>	<20080724072620.4197510c.krzysztof.h1@poczta.fm>	<4888B993.2040101@keyaccess.nl>
	<20080724204734.0ae77007.krzysztof.h1@poczta.fm>
	<4888D854.40509@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 40E7F2434A
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Aug 2008 03:47:16 +0200 (CEST)
In-Reply-To: <4888D854.40509@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, Alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 24-07-08 21:30, Rene Herman wrote:

>> If you have any of these please post results of your tests.
> 
> Will wait for V2 and will do; make take some time. I hope to not have
> time over the coming weekend...

Testing results. Only tested playback for now, not capture:


--- OPTi 92x (snd-opti92x-ad1848, snd-opti92x-cs4231)

Firstly, snd-opti92x-ad1848 doesn't work for anything anymore. The chip 
is each time detected as "OPTi 93x" instead of the actual AD/CS chip. 
Probably minor buglet -- I did not look, just mechanically switched 
cards and tested.

snd-opti92x-cs4231 works better:

OPTi		WSS		/proc/asund/cards		Result
---------------------------------------------------------------------
924		CS4231A-KL	"OPTi 82C924, CS4231"		Hangs
924		AD1845JP	"OPTi 82C924, AD1845"		Hangs
925		AD1845JP	"OPTi 82C925, AD1845"		Works
928		CS4248-KL	"OPTi 82C928, CS4231"		Works
929A		CS4248-KL	"OPTi 82C929, CS4231A"		Works
929A		AD1848		"OPTi 82C929, AD1848"		Works
929A		AD1845JP	"OPTi 82C929, AD1845"		Works
929A		AD1846JP"	"OPTi 82C929, AD1848"		Works

I've been running with the WSS code for some time locally and will need 
to recompile a vanilla kernel onto there to check 924. I expect it's not 
a regression.

As to your specific question -- CS4248 seems to be detected as CS4231(A)


--- OPTi 93x (snd-opti93x)

Chip		/proc/asound/cards		Result
------------------------------------------------------
930		"OPTi 82C930, OPTi 93x"		Works
931		"OPTi 82C931, OPTi 93x"		Works
933		"OPTi 82C933, OPTi 93x"		Works


--- Yamaha OPL3-SA2 (snd-opl3sa2)

Chip		/proc/asound/cards		Result
------------------------------------------------------
YMF719-S	"Yamaha OPL3-SA23"		Works
YMF719E-S	"Yamaha OPL3-SA23"		Works


--- CMI 8330 (snd-cmi8330)

Chip		/proc/asound/cards		Result
------------------------------------------------------
CMI8330A	"C-Media CMI8330/C3D"		Works


--- Crystal CS423x (snd-cs4232, snd-cs4236)

Chip		/proc/asound/cards		Result
------------------------------------------------------
CS4232		"CS4232"			Works
CX4235-XQ3	"CS4235"			Silent
CS4236B-KQ	"CS4236B"			Works
CX4236B-XQ3	"CS4236B"			Works
CX4237B-XQ3	"CS4237B"			Works
CS4239-KQ	"CS4239"			Works


I believe the CX4235 is simply broken -- everything looks in order, just 
no signal. Not expected to have anything to do with things.


--- Gravis Ultrasound MAX (snd-gusmax)

Gravis		WSS		"Chip"			Result
--------------------------------------------------------------
GF1		CS4231A-KL	"CS4231A"		Hangs

Definitely unrelated. Need to sit down one day and figure out what's 
wrong with the Gravis drivers.


--- Ensoniq SoundScape VIVO90 (snd-vivo local minimal driver)

Ensoniq		WSS		"Chip"			Result
--------------------------------------------------------------
OTTOR2C		AD1845JP	"AD1845"		Works

Also hve an older non-vivo SoundScape, but I haven't had that working 
yet (also not tried, but will at some point). It has an AD1848KP.


--- Aztech Sound Galaxy AZT2320 (snd-azt2320)

Chip: AZT2320

Ha, finally... this one looks to be a regression. I have an large stream of:

ALSA sound/isa/wss/wss_lib.c:229: codec out - reg 0xc = 0x0
ALSA sound/isa/wss/wss_lib.c:229: codec out - reg 0x0 = 0xaa
ALSA sound/isa/wss/wss_lib.c:229: codec out - reg 0x1 = 0x45
ALSA sound/isa/wss/wss_lib.c:229: codec out - reg 0xc = 0x0
ALSA sound/isa/wss/wss_lib.c:229: codec out - reg 0x0 = 0xaa
ALSA sound/isa/wss/wss_lib.c:229: codec out - reg 0x1 = 0x45

before it craps out (doesn't load). I'll look into it unless you beat me 
to it.


--- Aztech Sound Galaxy AZT1605/AZT2316 (local snd-galaxy)

Aztech		WSS		"Chip"			Result
--------------------------------------------------------------
AZT1605		CS4231-KL	To be tested		To be tested
AZT1605		CS4231A-KL	To be tested		To be tested
AZT1605		AD1845JP	To be tested		To be tested
AZT2316A	CS4248-KL	To be tested		To be tested
AZT2316A	CS4231A-KL	To be tested		To be tested
AZT2316A	AD1845XP	To be tested		To be tested
AZT2316R	CS4231A-KL	To be tested		To be tested
AZT2316-S	CS4231A-KL	To be tested		To be tested

I'll test these after reviving snd-galaxy. Saw you already tested one as 
well though.


--- Aztech Sound Galaxy NX Pro 16 (no driver yet)

AZTSSPT0592/AZT-NXPMIX0592 + AD1848KP


I believe those are all the WSS chips that I have. In the context of the 
WSS testing, the AZT2320 result is most interesting...

Rene.
