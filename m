From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Merging alsa-firmware into linux-firmware
Date: Wed, 21 Jul 2010 16:30:59 +0200
Message-ID: <4C4704A3.7040803@canonical.com>
References: <4C457C89.5040209@canonical.com>
	<4C45A538.2060704@ladisch.de>	<4C45C521.4020208@canonical.com>
	<4C469959.7020600@ladisch.de>	<4C46F6AE.3060208@canonical.com>
	<1279720939.6002.11.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 71354243A8
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Jul 2010 16:31:02 +0200 (CEST)
In-Reply-To: <1279720939.6002.11.camel@localhost>
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
Cc: Chase Douglas <chase.douglas@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 2010-07-21 16:02, David Woodhouse wrote:
> On Wed, 2010-07-21 at 14:31 +0100, David Henningsson wrote:
>> The emi26/emi62 firmware already exists in linux-firmware, so I won't
>> merge them either (and that patch in the link is against linux-firmware
>> and not alsa-firmware). 
> 
> I think the *wrong* version is in linux-firmware. 

But the alsa-firmware package currently puts the firmware into the
emagic/ directory, which AFAIK is not used at all by the current kernel.

> But nobody ever
> offered a patch to fix that (only a kernel source patch).

I think the link Clemens just posted goes to such a patch.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
