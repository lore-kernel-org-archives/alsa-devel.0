From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH v3] ALSA: aoa: convert bus code to use dev_groups
Date: Fri, 12 Jun 2015 11:59:40 +0200
Message-ID: <87mw05w8kz.fsf@igel.home>
References: <1432817307-28380-1-git-send-email-lambert.quentin@gmail.com>
	<1434098322-12178-1-git-send-email-lambert.quentin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1434098322-12178-1-git-send-email-lambert.quentin@gmail.com>
	(Quentin Lambert's message of "Fri, 12 Jun 2015 10:38:41 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Lambert <lambert.quentin@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Quentin Lambert <lambert.quentin@gmail.com> writes:

> The dev_attrs field of struct bus_type is going away, sue dev_groups instead.

s/sue/use/

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
