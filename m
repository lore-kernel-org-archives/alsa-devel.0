From: Rene Herman <rene.herman@gmail.com>
Subject: Re: Can someone verify support for "AzTech
 Sound	Galaxy Nova 16 Extra II-3D - using AZT-2316/R Chipset
 -	FCC-ID:I38-MMSN846" ?
Date: Thu, 17 May 2007 01:35:59 +0200
Message-ID: <464B955F.3030508@gmail.com>
References: <20070513101757.8C8191BF23B@ws1-1.us4.outblaze.com>
	<4648DA4E.8050107@gmail.com> <4648E10B.4010403@gmail.com>
	<20070515101259.GS5690@sygehus.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 60971243E2
	for <alsa-devel@alsa-project.org>;
	Thu, 17 May 2007 01:38:39 +0200 (CEST)
In-Reply-To: <20070515101259.GS5690@sygehus.dk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rask Ingemann Lambertsen <rask@sygehus.dk>
Cc: alsa-devel@alsa-project.org, ramkromberg@mail.com
List-Id: alsa-devel@alsa-project.org

On 05/15/2007 12:12 PM, Rask Ingemann Lambertsen wrote:

> On Tue, May 15, 2007 at 12:22:03AM +0200, Rene Herman wrote:
>  
>> As said. If you execute this as root it should enable the card. You can 
>> pick the base address (the one JMPB0 is set to) with "-p 0x220|0x240". 
>> Default is 0x200 if you don't specify one.
>              ^^^^^
>    0x220 or 0x240?

0x220.

> Do you think there is any point in trying any of this configuration stuff
> on an NXPro?

Probably not. The oldest Sound Galaxy I have is a NX Pro 16 (I38-MMSN803) 
and I haven't yet tested on that either. That one does have an EEPROM but 
the jumper doesn't select between EEPROM and software but between EEPROM and 
  "factory setting" which probably implies it's not software configurable.

(other than by writing to the EEPROM and rebooting the card with the jumper 
set to EEPROM; writing to the EEPROM is yet another fun little project for a 
future HWDEP interface in the driver but it's not an important feature).

Does your NX Pro have an EEPROM? It should be a small 8-pin chip marked with 
something close to "X24C00", near a clock chip and probably near an Intel 
8051 microcontroller. And does it have a jumper that sounds like it has 
anything to do with things?

>> 		return EXIT_FAILURE;
>> 	}
>>
>> 	return EXIT_SUCCESS;
> 
>    It is not often that I see other people use standards compliant return
> values from main().

0 and !0 are as standards compliant... :-)

Rene.
