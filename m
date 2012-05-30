From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Help requested: new HSS1394 MIDI back-end
Date: Wed, 30 May 2012 09:18:32 +0200
Message-ID: <4FC5C9C8.1000604@ladisch.de>
References: <94aa86f3-5257-402a-a094-f58fccdeb846@email.android.com>
	<38538c62-f01e-4743-be92-aea79d61085e@email.android.com>
	<4FC5AC47.4060606@mixxx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 2FC0B2457A
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2012 09:18:35 +0200 (CEST)
In-Reply-To: <4FC5AC47.4060606@mixxx.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Sean M. Pappalardo - D.J. Pegasus" <spappalardo@mixxx.org>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sean M. Pappalardo - D.J. Pegasus wrote:
> On 05/30/2012 06:51 AM, Clemens Ladisch wrote:
>> Sean M. Pappalardo - D.J. Pegasus wrote:
>>> four-byte platter messages that start with
>>> 0xF9 and the remaining three can range from 0x00 to 0xFF.
>>
>> This is not MIDI. Into what MIDI messages should
>> the driver convert this?
>
> It shouldn't convert it at all. Just deliver it as-is in a single
> four-byte message, if possible.

The problem is the communication between the driver and userspace;
_that_ must be valid MIDI.

> 0xF9 is a valid, if undefined, MIDI status.

Undefined means invalid.  Furthermore, data bytes must not have the
eighth bit set.

> I will also need the ability to use the HSS1394 SendUserControl
> function to set the device's timers, and that is definitely not MIDI
> at all.
> I wonder if it would be a good idea to define a special SYSEX message
> that the SCS1x driver would interpret and convert to a call to that
> function?

As it happens, the actual SysEx commands use the wrong manufacturer ID
("00 01 02" is Crystal Semiconductor); I could just use the real ID
(Stanton is "00 01 60") to escape non-MIDI HSS1394 messages.  Let's add
"HSS" to identify this, and to allow the full byte range, each HSS1394
byte is split into two nibbles.  So:

00 F9 xx yy zz -> F0 00 01 60 48 53 53 00 00 0F 09 0x 0x 0y 0y 0z 0z F7
13 xx yy zz    <- F0 00 01 60 48 53 53 01 03 0x 0x 0y 0y 0z 0z F7
14 xx yy zz    <- F0 00 01 60 48 53 53 01 04 0x 0x 0y 0y 0z 0z F7
(0x13 = 0x10 + 3 = kUserTagBase + uUserTag)


Regards,
Clemens
