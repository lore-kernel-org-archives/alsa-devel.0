From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Capture from 3+ cards connected to a USB hub -
 distorted samples
Date: Wed, 14 Dec 2011 13:30:42 +0100
Message-ID: <4EE896F2.9090806@perex.cz>
References: <4EE29877.2050804@ivitera.com> <4EE89434.9040609@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [77.48.224.245])
	by alsa0.perex.cz (Postfix) with ESMTP id D5397103822
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 13:31:29 +0100 (CET)
In-Reply-To: <4EE89434.9040609@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 14.12.2011 13:19, Pavel Hofman wrote:
>
> Dne 10.12.2011 00:23, Pavel Hofman napsal(a):
>> Hi,
>>
>> I have been informed about the following problem which I was able to
>> reproduce afterwards:
>>
>> * Latest git.alsa-project.org drivers
>>
>> * USB 2.0 hub, 3 or more USB soundcards (inexpensive USB sticks, USB
>> audio v.1 types, async capture, adaptive playback) hooked to the hub,
>> identified A, B, C, D.
>>
>> * NONE of these soundcards is playing back
>>
>> Now:
>>
>> * Card A begins microphone capturing (mono 48/16), result OK
>>
>> * Card B begins capturing (mono 48/16), both results still OK
>>
>> * As soon as the third card C begins capturing, the signal captured from
>>    cards A and B gets distorted. Audacity shows some samples are
>> incorrect, distorting the expected sine waveform of the testing signal.
>> I can provide screenshots as well as recorded samples, if needed.
>>
>> * The signal recorded from card C is OK.
>>
>> BUT
>>
>> * If any card hooked to the HUB is playing back (even a fourth one D),
>> the distortion does not occur. It happens only when there is no playback
>> stream going through the hub. Traffic on another USB port has no effect,
>> in fact the test signal for the three cards was provided by a
>> multichannel USB card hooked to another USB port.
>>
>> It seems to me as if blocks of samples for each card in the USB frame
>> sometimes overlap by a few bits, corrupting the neighbouring card
>> samples, or are recovered incorrectly.
>>
>> I understand I have provided no real data, I am ready to do so plus any
>> tests you would consider useful.
>>
>> Thanks a lot for suggestions of the next debugging steps I should do.
>>
>
> Hi, please may I ask for help? I think we could fix this likely bug.

This looks like a USB core issue (lost / unsynced URBs from isochronous 
transfers). I would try recent linux kernels and/or ask on the USB 
development list for a help.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
