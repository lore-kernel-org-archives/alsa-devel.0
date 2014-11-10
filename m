From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/3 v4] ALSA: usb-audio: Move mutex
	define	to more general location
Date: Mon, 10 Nov 2014 10:47:57 +0100
Message-ID: <546089CD.60100@ladisch.de>
References: <1415612437-5557-1-git-send-email-damien@zamaudio.com>
 <1415612437-5557-2-git-send-email-damien@zamaudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 132242605B6
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 10:47:59 +0100 (CET)
In-Reply-To: <1415612437-5557-2-git-send-email-damien@zamaudio.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien.zammit@gmail.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Damien Zammit <damien@zamaudio.com>
List-Id: alsa-devel@alsa-project.org

Damien Zammit wrote:
> Allow quirks to lock/unlock the usb audio register mutex by moving
> its definition to usbaudio.h
>
> +++ b/sound/usb/usbaudio.h
>
> +static DEFINE_MUTEX(register_mutex);

This does not work in a header file.


Regards,
Clemens
