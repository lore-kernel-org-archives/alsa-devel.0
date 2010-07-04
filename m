From: Florian Scholz <florian90@gmail.com>
Subject: Re: ESI DuaFire Vendor Information
Date: Sun, 4 Jul 2010 12:41:20 +0200
Message-ID: <AANLkTilpVLFFuVrHq7uNMP71PaazX9qnchTSdbwyWU-g@mail.gmail.com>
References: <AANLkTimFQAkrDUrqFixX3zZuY3z69p4Q0jxnfFrN-cey@mail.gmail.com>
	<4C304E3F.7010709@joow.be>
	<AANLkTimP6gB0soXH9R7gBohFiG0DUClc6lgzCOtFnt4N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id C561910381A
	for <alsa-devel@alsa-project.org>;
	Sun,  4 Jul 2010 12:41:20 +0200 (CEST)
Received: by bwz4 with SMTP id 4so2436998bwz.38
	for <alsa-devel@alsa-project.org>; Sun, 04 Jul 2010 03:41:20 -0700 (PDT)
In-Reply-To: <AANLkTimP6gB0soXH9R7gBohFiG0DUClc6lgzCOtFnt4N@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pieter Palmers <pieterp@joow.be>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/7/4, Florian Scholz <florian90@gmail.com>:
> I tried it. FFADO can't read the info registers. Also the default
> BEBOB driver can't find the streams, so it isn't supported. This is
> the reason why I believe that I have to write a driver for it to get
> it working. It's hard to find a soundcard in this price range with an
> integrated phono amplifer and furthermore a Hi-Z Input :)
>
>
>
> 2010/7/4, Pieter Palmers <pieterp@joow.be>:
>> Have you tried running it with FFADO? There is a good chance that it
>> will work.
>>
>> Regards,
>>
>> Pieter
>>
>> On 07/02/2010 05:11 PM, Florian Scholz wrote:
>>> Hi
>>>
>>> I like to implement a driver for the ESI DuaFire Interface and need
>>> the information from ESI.
>>>
>>> Andreas Preuss from ESI wrote me (translated):
>>>
>>> thanks you for your message. every information that you need for the
>>> development of a firewire audio driver are public. the information are
>>> accessable for the alsa-project and maybe the ffado project.
>>> _______________________________________________
>>> Alsa-devel mailing list
>>> Alsa-devel@alsa-project.org
>>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>>
>>
>>
>


here are the ffado errors:

00865470454: Warning (bebob_avdevice.cpp)[ 188] discover: Using
generic BeBoB support for unsupported device 'EGOSYS, Ltd.
ESI_DuaFire'
00865504687: Error (bebob_avplug.cpp)[ 161] discover: Could not
discover stream format (0,31,255,0,0)
00865504709: Error (avc_unit.cpp)[ 442] discoverPlugsPCR: plug
discovering failed
00865504724: Error (avc_unit.cpp)[ 394] discoverPlugs: pcr input plug
discovering failed
00865504735: Error (avc_unit.cpp)[ 182] discover: Detecting plugs failed
00865504742: Error (bebob_avdevice.cpp)[ 192] discover: Could not discover unit
00865504753: Error (devicemanager.cpp)[ 606] discover: could not discover device
no message buffer overruns


information from bebob downloader (display):

01512433725: Error (bebob_dl_mgr.cpp)[  90] BootloaderManager:
BootloaderManager: could not cache info registers
Config ROM
	Current Node Id:	0
	GUID:			0x0030E00200454647
	Vendor Name:		EGOSYS, Ltd.
	Model Name:		ESI_DuaFire
	Node Vendor ID:		0x0030e0
	Model Id:		0x0000f970
	Unit Specifier ID:	0x00a02d
	Unit version:		0x00010001
	ISO resource manager:	0
	Cycle master capable:	1
	Bus manager capable:	0
	Cycle clock accuracy:	255
	Max rec:		5 (max asy payload: 64 bytes)
01512484219: Error (bebob_dl_mgr.cpp)[ 187] printInfoRegisters: Could
not read info registers
no message buffer overruns
