From: "D. Sen" <dsen@homemail.com>
Subject: Re: RME madiface
Date: Fri, 11 Jul 2008 16:50:07 +1000
Message-ID: <4877029F.6080006@homemail.com>
References: <48769BDC.80007@homemail.com>
	<200807110626.52197.faber@faberman.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout08.prod.mesa1.secureserver.net
	(smtpout08-04.prod.mesa1.secureserver.net [64.202.165.12])
	by alsa0.perex.cz (Postfix) with SMTP id 476FE103819
	for <alsa-devel@alsa-project.org>;
	Fri, 11 Jul 2008 08:50:24 +0200 (CEST)
In-Reply-To: <200807110626.52197.faber@faberman.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Florian Faber <faber@faberman.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Florian Faber wrote:
> Pleaseuseafullname,
> 
>> I have been trying to use the hdspm driver with a recently purchased
>> RME Madiface device. The functionality that I require is to play
>> various files through various channels under program (script)
>> control. I am happy to report that it *almost* works - in that I can
>> use my simple userspace programs to play files. However, there are
>> subtle problems - in that the external MADI A-to-D (an Euphonix 703)
>> does not seem to lock into the sampling rate (something that works
>> under windows). Its very close to achieving full functionality (for
>> my needs) - but just that tiny bit away from being fully useable.
>>
>> Any ideas?
> 
> There is no difference on the MADI bus wether you use Windows, OS X or 
> Linux. This seems to be a specific problem with the Euphonix.

I have no reason to believe the MADI bus is different. However, I
suspect the stream are different.

I have two Euphonix boxes and they both behave perfectly under windows -
but not under linux. The main problem under linux is that they lose sync
- at the slightest electromagnetic interference (such as turning off/on
the speakers - on the analogue side - even from a distance of 3 metres).
The actual detection of the incorrect sampling rate (or "custom") while
disconcerting is not really much of a problem if the files are playing fine.


> 
> What are the exact parameters you use on Windows (when the Euphonix 
> worked)?

Windows Parameters:

Buffer Size: 256
Clock Mode: Both "Auto sync" and "Master"
Madi Out: Both "56" and "64"
WDM Devices: 32
96 kHz: both "48 k" and "96 k" Frame
System Clock: 44.1
DDS: not selected

The linux parameters:
>cat /proc/asound/card0/hdspm
RME HDSPM MADI (Card #2) Rev.d5 Status2first3bits: 1
IRQ: 16 Registers bus: 0xe3100000 VM: 0xffffc20009640000
--- System ---
IRQ Pending: Audio=0, MIDI0=0, MIDI1=0, IRQcount=109
HW pointer: id = 0, rawptr = 0 (0->65472) estimated= 0 (bytes)
MIDI FIFO: Out1=0x0, Out2=0x0, In1=0x80, In2=0x80
Register: ctrl1=0x1094c9e, ctrl2=0x0, status1=0xc00000, status2=0xc0050701
--- Settings ---
Size (Latency): 8192 samples (2 periods of 32768 bytes)
Line out: on ,   Precise Pointer: off
Inputsel = Coaxial, SyncRef = MADI
ClearTrackMarker = on, Transmit in 64 Channel Mode, Auto Input on
Sample Clock Source: Internal 44.1 kHz
System Clock Mode: Master
Preferred Sync Reference: MADI Sync
System Clock Frequency: 44100
--- Status:
Inputs MADI=NoLock, WordClock=NoLock
AutoSync: Reference= Input not valid, Freq=0 (MADI = 3, Word = 0)
Input: Optical, Mode=56 channels

> 
>> Havent had much luck contacting RME and Winfried Ritsch (who
>> wrote/maintains the code).
> 
> I maintain the code at the moment.
> 

Good to hear.

> 
> Flo
Dee

-- 
Dr. D. Sen
School of Electrical Engineering & Telecommunications
University of New South Wales
Sydney
NSW 2052
Australia
Tel: +612+93854754
