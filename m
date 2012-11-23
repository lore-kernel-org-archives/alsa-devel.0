From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: SNDRV_PCM_TRIGGER_STOP not called
Date: Fri, 23 Nov 2012 21:07:40 +0100
Message-ID: <50AFD78C.60001@ladisch.de>
References: <50AF61B2.5@sasken.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 9BC9D26260B
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 21:07:56 +0100 (CET)
In-Reply-To: <50AF61B2.5@sasken.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: irfanks <irfan.shaikh@sasken.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

irfanks wrote:
> We are facing issue when forceful disconnection of isochronous USB ALSA device (IPOD).
>
> Problems as below :
> 1) SNDRV_PCM_TRIGGER_STOP in snd_usb_substream_capture_trigger() is not getting called.

And why is that a problem?


Regards,
Clemens
