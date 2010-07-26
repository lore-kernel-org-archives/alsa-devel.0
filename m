From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Merging alsa-firmware into linux-firmware
Date: Mon, 26 Jul 2010 10:15:10 +0200
Message-ID: <4C4D440E.7060505@canonical.com>
References: <4C457C89.5040209@canonical.com>
	<1279623084.29277.1.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 928B5246C7
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jul 2010 10:15:13 +0200 (CEST)
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

2010-07-20 12:51, David Woodhouse skrev:
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
> 

Okay, so now there's a preliminary version up for review here:
git://kernel.ubuntu.com/diwic/linux-firmware.git, alsa-merge branch.

Feel free to either merge it if you think it's okay, or if it needs
adjustments, let me know (or fix them yourself, whatever is simplest...).

Note that once this one's through, we should adjust alsa-tools for usx2y
to point to /lib/firmware/usx2y and nothing else.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
