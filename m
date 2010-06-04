From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] alsa-lib: snd_pcm_delay and friends do not
 account for a write being currently in progress
Date: Fri, 04 Jun 2010 08:50:56 +0200
Message-ID: <4C08A250.3020308@ladisch.de>
References: <1275514176.8032.42.camel@satellite>
	<AANLkTil3VZiQe5wSezaDRXtekheR6d_hs7wKK6Ku7puX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id 865B2103824
	for <alsa-devel@alsa-project.org>;
	Fri,  4 Jun 2010 08:51:05 +0200 (CEST)
In-Reply-To: <AANLkTil3VZiQe5wSezaDRXtekheR6d_hs7wKK6Ku7puX@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: VDR User <user.vdr@gmail.com>
Cc: alsa-devel@alsa-project.org, John Lindgren <john.lindgren@tds.net>
List-Id: alsa-devel@alsa-project.org

VDR User wrote:
> I've been getting "pcm_hw.c: snd_pcm_hw_delay() SNDRV_PCM_IOCTL_DELAY
> failed." in my xine log

The actual error (code) is missing.

> and after some talks with one of the devs, he suggested that alsa was
> not getting data fast enough in some cases (iirc).

That would be an underrun.  This has nothing to do with the
interpretation of snd_pcm_delay's return value; this function just
appears in the log because it happend to be the first one that detected
this error condition.  An underrung cannot be prevented by any change
in alsa-lib; xine needs to use a larger buffer, or the scheduling needs
to be improved so that some other thread or program doesn't prevent xine
from being executed.


Regards,
Clemens
