From: Chris J Arges <chris.j.arges@canonical.com>
Subject: Re: [PATCH v2] Scarlett mixer interface for 6i6, 18i6,
	18i8 and 18i20
Date: Wed, 22 Oct 2014 13:44:12 -0500
Message-ID: <5447FAFC.9040204@canonical.com>
References: <1413920787-4877-1-git-send-email-chris.j.arges@canonical.com>	<1413920787-4877-2-git-send-email-chris.j.arges@canonical.com>
 <s5h1tq0egzi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B1FB326528B
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 20:44:16 +0200 (CEST)
In-Reply-To: <s5h1tq0egzi.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, robin@gareus.org, clemens@ladisch.de, th55@gmx.de, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org



On 10/22/2014 01:49 AM, Takashi Iwai wrote:
> At Tue, 21 Oct 2014 14:46:27 -0500,
> Chris J Arges wrote:
>>
>> This code contains the Scarlett mixer interface code that was originally
>> written by Tobias Hoffman and Robin Gareus. Because the device doesn't
>> properly implement UAC2 this code adds a mixer quirk for the device.
>>
>> Changes from the original code include removing the metering code along with
>> dead code and comments. Compiler warnings were fixed. The code to initialize
>> the sampling rate was causing a crash this was fixed as discussed on the
>> mailing list. Error, and info messages were convered to dev_err and dev_info
>> interfaces. Finally the code was placed in its own subdirectory.
>>
>> Author: Tobias Hoffman <th55@gmx.de>
>> Author: Robin Gareus <robin@gareus.org>
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>> Signed-off-by: Chris J Arges <chris.j.arges@canonical.com>
>> ---
>>  sound/usb/Makefile                 |    1 +
>>  sound/usb/mixer.c                  |   27 +-
>>  sound/usb/quirks-table.h           |   51 --
>>  sound/usb/scarlett/scarlettmixer.c | 1264 ++++++++++++++++++++++++++++++++++++
>>  sound/usb/scarlett/scarlettmixer.h |    6 +
>>  5 files changed, 1293 insertions(+), 56 deletions(-)
>>  create mode 100644 sound/usb/scarlett/scarlettmixer.c
>>  create mode 100644 sound/usb/scarlett/scarlettmixer.h
>>
>> diff --git a/sound/usb/Makefile b/sound/usb/Makefile
>> index 2b92f0d..4267e47 100644
>> --- a/sound/usb/Makefile
>> +++ b/sound/usb/Makefile
>> @@ -12,6 +12,7 @@ snd-usb-audio-objs := 	card.o \
>>  			pcm.o \
>>  			proc.o \
>>  			quirks.o \
>> +			scarlett/scarlettmixer.o \
> 
> Any reason to create a subdirectory although it's no individual
> driver?  Put rather in the plain directory.
> 
I thought it would be neater, but I'll put the file back in the main
sound/usb directory. If the code is small enough I could add it to
mixer_quirks.c.

> Overall, there seem too many copies from mixer.c.  Can't we rather
> extend the stuff in mixer.c, make some of them global and let access
> from scalettmixer.c?
> 

Yes, I can work on this, I think it would help reduce the code redundancy.

> 
> Takashi
> 

Thank you,
--chris
