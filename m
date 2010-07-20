From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Merging alsa-firmware into linux-firmware
Date: Tue, 20 Jul 2010 15:31:36 +0200
Message-ID: <4C45A538.2060704@ladisch.de>
References: <4C457C89.5040209@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2F7B510390A
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jul 2010 15:31:51 +0200 (CEST)
In-Reply-To: <4C457C89.5040209@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Chase Douglas <chase.douglas@canonical.com>, alsa-devel@alsa-project.org, David Woodhouse <david.woodhouse@intel.com>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
> Chase Douglas (@canonical) and I plan to take what's left of
> alsa-firmware and try to merge it into linux-firmware, this might happen
> now or in the coming weeks. This will make alsa-firmware obsolete as all
> firmware will be provided by linux-firmware instead.

Good idea; these packages have exactly the same purpose.

> Any words of ... warnings

I wonder what you're going to do about the multisound firmware files;
the /lib/firmware/turtlebeach/*.bin files are just symbolic links to
the actual files in /etc/sound that owners of these cards (if any such
still exist) are supposed to have.  

The stuff in emi_26_62 isn't used.  (Er, wasn't there a regression
introduced in the emi62 firmware in 2.6.27?)


Regards,
Clemens
