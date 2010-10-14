From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Add speaker pin to automute
 Acer Aspire 8943G
Date: Thu, 14 Oct 2010 14:22:31 +0800
Message-ID: <AANLkTimu4xyGTKPqV8hRRAthuraACrat9g4mmYpgHX5K@mail.gmail.com>
References: <4CB68FC7.2060601@canonical.com>
	<4CB69FA4.9030702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 04A7B10388C
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 08:22:31 +0200 (CEST)
Received: by ewy9 with SMTP id 9so1843862ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2010 23:22:31 -0700 (PDT)
In-Reply-To: <4CB69FA4.9030702@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/10/14 Valentine Sinitsyn <valentine.sinitsyn@gmail.com>

> Hi David,
>
> First of all, thank you for your work on subwoofer issues. I've had a
> chance to test them on my system lately, and they do really fix the bug
> reported, but another one (more serious, in my opinion) remains:
> subwoofer is not muted via normal mute button (more precisely, by muting
> Master ALSA mixer). The problem is that during autoconfiguration
> procedure, subwoofer is mapped on PCM channel, and there seems (at least
> to me) to be no reliable way to distinguish subwoofer from other
> possibly existing outputs on a general system and change this behavior.
> Creating dedicated presets for the machines with a subwoofer seems to be
> right way to workaround this, but then _quirks you've implemented should
> be merged with this preset.
>
> Does this sound reasonable to you or I am missing anything?
>
> Thanks.
>

Do you mean that you want to add that "subwoofer" control which is connected
the the master mono pin of the codec  to the slave controls of the virtual
master volume control ?
