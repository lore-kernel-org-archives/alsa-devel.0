From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Merging alsa-firmware into linux-firmware
Date: Tue, 20 Jul 2010 17:47:45 +0200
Message-ID: <4C45C521.4020208@canonical.com>
References: <4C457C89.5040209@canonical.com> <4C45A538.2060704@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D48E103800
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 17:47:48 +0200 (CEST)
In-Reply-To: <4C45A538.2060704@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Chase Douglas <chase.douglas@canonical.com>, alsa-devel@alsa-project.org, David Woodhouse <david.woodhouse@intel.com>
List-Id: alsa-devel@alsa-project.org

On 2010-07-20 15:31, Clemens Ladisch wrote:
> David Henningsson wrote:
>> Chase Douglas (@canonical) and I plan to take what's left of
>> alsa-firmware and try to merge it into linux-firmware, this might happen
>> now or in the coming weeks. This will make alsa-firmware obsolete as all
>> firmware will be provided by linux-firmware instead.
> 
> Good idea; these packages have exactly the same purpose.
> 
>> Any words of ... warnings
> 
> I wonder what you're going to do about the multisound firmware files;
> the /lib/firmware/turtlebeach/*.bin files are just symbolic links to
> the actual files in /etc/sound that owners of these cards (if any such
> still exist) are supposed to have.  

Ah, thanks for bringing this up to my attention. From where do these
.bin-files come originally? Can we include them?

> The stuff in emi_26_62 isn't used.  (Er, wasn't there a regression
> introduced in the emi62 firmware in 2.6.27?)

I noticed that linux-firmware had one emi26 and one emi62 directory, as
opposed to alsa-firmware that puts it in the emagic directory. So given
your comment, I'll just drop them from the emagic dir.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
