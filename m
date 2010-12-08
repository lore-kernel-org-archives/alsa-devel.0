From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH] Fix possible sprintf overrun in
	snd_pcm_hw_open
Date: Wed, 08 Dec 2010 13:12:26 +0100
Message-ID: <4CFF762A.9080501@ladisch.de>
References: <4CFF5AF3.5030103@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id C024B103C16
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 13:10:41 +0100 (CET)
In-Reply-To: <4CFF5AF3.5030103@canonical.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
> Possible buffer overrun if the number of "card" and "device"
> are absurdly high, especially on 64-bit platforms.

The size of "int" is 32 bits even on 64-bit platforms.

As far as I can see, there is no bug.


Regards,
Clemens
