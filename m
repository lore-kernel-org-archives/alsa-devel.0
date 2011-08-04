From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 0/3] 3 Patches for better UAC2 handling
Date: Thu, 04 Aug 2011 16:11:33 +0200
Message-ID: <4E3AA895.2090307@ladisch.de>
References: <1312466188-3428-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 9565624464
	for <alsa-devel@alsa-project.org>;
	Thu,  4 Aug 2011 16:08:05 +0200 (CEST)
In-Reply-To: <1312466188-3428-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> Daniel Mack (2):
>   ALSA: snd-usb: Accept UAC2 FORMAT_TYPE descriptors with bLength > 6
>   ALSA: snd-usb: operate on given mixer interface only
> 
> Nicolai Krakowiak (1):
>   ALSA: snd-usb: avoid dividing by zero on invalid input

For all three:
Acked-by: Clemens Ladisch <clemens@ladisch.de>

> CC: <stable@kernel.org>

This must go _only_ into the patch description, because patches cannot
be submitted to the stable trees as long as they aren't yet in Linus'
tree.


Regards,
Clemens
