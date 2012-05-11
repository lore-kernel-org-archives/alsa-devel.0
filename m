From: Felix Homann <linuxaudio@showlabor.de>
Subject: snd-usb-audio: Substream status not set with new
	streaming logic
Date: Fri, 11 May 2012 12:53:45 +0200
Message-ID: <CAFz=ag5u7Ks3e=9R_A5Scwk361Hw1fFLyr+StWU2hjxD40JMQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gg0-f179.google.com (mail-gg0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id F41F410BB6E
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 12:53:46 +0200 (CEST)
Received: by ggnk3 with SMTP id k3so1680898ggn.38
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2012 03:53:46 -0700 (PDT)
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

With the new streaming logic subs->running will never be set to 1. So
/proc/... will never show the streams as running. Formerly the status
was set in endpoint.c.

Daniel?

Regards,

Felix
