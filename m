From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Help requested: new HSS1394 MIDI back-end
Date: Fri, 01 Jun 2012 10:22:48 +0200
Message-ID: <4FC87BD8.8070104@ladisch.de>
References: <94aa86f3-5257-402a-a094-f58fccdeb846@email.android.com>
	<38538c62-f01e-4743-be92-aea79d61085e@email.android.com>
	<4FC5AC47.4060606@mixxx.org> <4FC5C9C8.1000604@ladisch.de>
	<4FC7EB01.1070306@mixxx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id ABB1A1044E9
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Jun 2012 10:22:53 +0200 (CEST)
In-Reply-To: <4FC7EB01.1070306@mixxx.org>
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
> On 05/30/2012 09:18 AM, Clemens Ladisch wrote:
>> As it happens, the actual SysEx commands use the wrong manufacturer ID
>> ("00 01 02" is Crystal Semiconductor); I could just use the real ID
>> (Stanton is "00 01 60") to escape non-MIDI HSS1394 messages.  Let's add
>> "HSS" to identify this, and to allow the full byte range, each HSS1394
>> byte is split into two nibbles.
>
> That all sounds good, but that now means that applications that want
> to use these device features must have different code for Linux than
> they do for Windows or OSX.

IIRC it was decided to use a MIDI driver in order to allow other
applications to access these devices with standard MIDI APIs.
(Does this imply that on Windows and OS X, it is not possible to
access them without using the HSS1394 library?)

You could still port the HSS1394 library so that it sits on top of the
MIDI driver.  (In other words, the Linux MIDI backend would be the
equivalent of the Windows and OS X FireWire backends.)


Regards,
Clemens
