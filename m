From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Merging alsa-firmware into linux-firmware
Date: Wed, 21 Jul 2010 11:29:45 +0200
Message-ID: <4C46BE09.5050309@canonical.com>
References: <4C457C89.5040209@canonical.com>
	<1279623084.29277.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 52A2B24395
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 11:29:48 +0200 (CEST)
In-Reply-To: <1279623084.29277.1.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Woodhouse <dwmw2@infradead.org>
Cc: "chase.douglas@canonical.com" <chase.douglas@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 2010-07-20 12:51, David Woodhouse wrote:
> On Tue, 2010-07-20 at 11:38 +0100, David Henningsson wrote:
>> Hi,
>>
>> Chase Douglas (@canonical) and I plan to take what's left of
>> alsa-firmware and try to merge it into linux-firmware, this might happen
>> now or in the coming weeks. This will make alsa-firmware obsolete as all
>> firmware will be provided by linux-firmware instead.
>>
>> Any words of disagreement, warnings or encouragement before we do so?
> 
> Encouragement, certainly...

Great!

There are a few firmwares (e g echoaudio and hdsploader) that actually
are .c files with a big constant array in it, like this:

static u_int32_t digiface_firmware[24413] = {
0xffffffff, 0x66aa9955, 0x8001000c, 0xe0000000, 0x8006800c, 0xb0000000,
0x8004800c, 0xb4fc0100, 0x8003000c, 0x00000000, 0x8001000c, 0x90000000,
...etc...

Would you prefer the actual .c files in the linux-firmware git tree
source (and the makefile that goes with it), or just the output from
them (the binary firmware files)?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
