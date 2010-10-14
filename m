From: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Add speaker pin to automute
 Acer Aspire 8943G
Date: Thu, 14 Oct 2010 12:13:56 +0600
Message-ID: <4CB69FA4.9030702@gmail.com>
References: <4CB68FC7.2060601@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C142103882
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 08:13:56 +0200 (CEST)
Received: by ewy9 with SMTP id 9so1841352ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2010 23:13:56 -0700 (PDT)
In-Reply-To: <4CB68FC7.2060601@canonical.com>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi David,

First of all, thank you for your work on subwoofer issues. I've had a 
chance to test them on my system lately, and they do really fix the bug 
reported, but another one (more serious, in my opinion) remains: 
subwoofer is not muted via normal mute button (more precisely, by muting 
Master ALSA mixer). The problem is that during autoconfiguration 
procedure, subwoofer is mapped on PCM channel, and there seems (at least 
to me) to be no reliable way to distinguish subwoofer from other 
possibly existing outputs on a general system and change this behavior. 
Creating dedicated presets for the machines with a subwoofer seems to be 
right way to workaround this, but then _quirks you've implemented should 
be merged with this preset.

Does this sound reasonable to you or I am missing anything?

Thanks.

Regards,
Valentine Sinitsyn
