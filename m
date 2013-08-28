From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: where to get snd_pcm_hardware info when usb audio
 device plug in?
Date: Wed, 28 Aug 2013 16:22:25 +0200
Message-ID: <521E07A1.5020807@ladisch.de>
References: <CANudz+uTk+GDAj=NfHQ_6ZrL6=ZmWJfXAnwRqk7yHPr4s0Jg1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id D1EBA265458
 for <alsa-devel@alsa-project.org>; Wed, 28 Aug 2013 16:22:28 +0200 (CEST)
In-Reply-To: <CANudz+uTk+GDAj=NfHQ_6ZrL6=ZmWJfXAnwRqk7yHPr4s0Jg1A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: loody <miloody@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

loody wrote:
> is it possible to get snd_pcm_hardware information in /proc, /sys or
> anywhere when usb audio device plug in?
>
> if no, is there api I can take in usermode to get snd_pcm_hardware of
> this usb audio device?

Something like this?
http://download.atmark-techno.com/misc/demos/usb-audio-a500-howto/hw_params.c


Regards,
Clemens
