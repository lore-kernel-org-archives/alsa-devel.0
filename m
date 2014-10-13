From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [WIP PATCH] Scarlett mixer interface for 6i6, 18i6,
	18i8 and 18i20.
Date: Mon, 13 Oct 2014 14:09:42 +0200
Message-ID: <543BC106.1050003@ladisch.de>
References: <1412694986-2537-1-git-send-email-david.henningsson@canonical.com>	<543BB04D.8000906@googlemail.com>
 <543BB9CF.7010806@ladisch.de> <543BBF44.3020109@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 5131126053A
 for <alsa-devel@alsa-project.org>; Mon, 13 Oct 2014 14:09:58 +0200 (CEST)
In-Reply-To: <543BBF44.3020109@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Tobias Hoffmann <smilingthax@googlemail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, robin@gareus.org, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Tobias Hoffmann wrote:
> Here are two reports (6i6) with oops trace:
>   https://github.com/smilingthax/alsa-driver_scarlett/issues/7
>   https://github.com/smilingthax/alsa-driver_scarlett/issues/2#issuecomment-54364354

Both kernels are tainted.
Anyway, in both cases, the simplest explanation would be that the driver
was not compiled for the correct kernel version/configuration.


Regards,
Clemens
