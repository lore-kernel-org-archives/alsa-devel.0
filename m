From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] ALSA: firewire: Neaten cmp_error function
Date: Thu, 20 Oct 2011 08:36:55 +0200
Message-ID: <4E9FC187.4060309@ladisch.de>
References: <1319086869.28078.6.camel@Joe-Laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id B65B11039A5
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Oct 2011 08:35:37 +0200 (CEST)
In-Reply-To: <1319086869.28078.6.camel@Joe-Laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joe Perches <joe@perches.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Joe Perches wrote:
> Use an actual struct va_format instead of casting
> an array of pointers.

> -	dev_err(&c->resources.unit->device, "%cPCR%u: %pV",
> -		'i', c->pcr_index, &(struct va_format){ fmt, &va });

There is no cast.  This compound literal _is_ an actual
struct va_format.

> Move a constant char argument to the format string.

Good catch, but this module is going to be extended to handle
oPCRs, too.


Regards,
Clemens
