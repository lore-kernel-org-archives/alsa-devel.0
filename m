From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Can someone verify support for "AzTech Sound
 Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset - FCC-ID:I38-MMSN846"
 ?
Date: Thu, 17 May 2007 01:23:56 +0200
Message-ID: <464B928C.7010806@gmail.com>
References: <20070515085016.C02081BF258@ws1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 8A1A6243DA
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2007 01:26:36 +0200 (CEST)
In-Reply-To: <20070515085016.C02081BF258@ws1-1.us4.outblaze.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ramkromberg@mail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 05/15/2007 10:50 AM, ramkromberg@mail.com wrote:

> You did it Rene !!!
>  >sudo ./eeprom
>  >sudo modprobe snd-sgalaxy sbport=0x220 wssport=0x530
> 
> It's working now !!

Great. Thanks for testing/reporting.

> I downloaded the binary (i didn't compile the code), chmod it, sudo it 
> and the sgalaxy worked !!!
> the sb8 didn't work but I don't really care for that anyhow :-)

Mmm. That was probably then since the card was already in WSS mode. If you'd 
boot straight into Linux (from a hardware reset/machine off state certainly) 
and run that "eeprom" tool as the first thing you do, then:

	modprobe snd-sb8 port=0x220 irq=5 dm8=1

should work. If not, I have some further figuring to do. I did figure out 
how to switch the card back to SB mode from WSS mode already, but am seeing 
some trouble with where (and how often...) to reset the DSP to have it back 
again after that.

> For the record, I tested it on xubuntu 7.04 with xmms.
> 
> Are you now planning to implement the code to the driver itself ? If you
> want me to test anything, let me know.

Yes, this will find it's way into an ALSA driver shortly. Since I'm seeing 
some trouble again with putting the card back in SB mode from WSS mode I'm 
giving it a bit of a rest for now while I continue the things I actually 
_should_ have been doing right now (...) but I will make sure a new driver 
gets submitted that supports our EEPROM-less Sound Galaxies...

Rene.
