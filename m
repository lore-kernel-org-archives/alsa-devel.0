From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 4/5] ALSA: snd-usb: set MAX_URBS to 16
Date: Tue, 01 Nov 2011 21:57:39 +0100
Message-ID: <4EB05D43.2030609@ladisch.de>
References: <1320063030-3502-1-git-send-email-zonque@gmail.com>
	<1320063030-3502-5-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id E324E10391F
	for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2011 21:57:43 +0100 (CET)
In-Reply-To: <1320063030-3502-5-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: tiwai@suse.de, blablack@gmail.com, alsa-devel@alsa-project.org, gdiffey@gmail.com, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

Daniel Mack wrote:
> This is needed for implicity feedback data streams.

Why?

> -#define MAX_URBS	8
> +#define MAX_URBS	16


Regards,
Clemens
