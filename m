From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda: Add speaker pin to automute
 Acer Aspire 8943G
Date: Thu, 14 Oct 2010 09:49:07 +0200
Message-ID: <4CB6B5F3.9000700@canonical.com>
References: <4CB68FC7.2060601@canonical.com> <4CB69FA4.9030702@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id A4EFB103869
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 09:49:11 +0200 (CEST)
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
To: Valentine Sinitsyn <valentine.sinitsyn@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 2010-10-14 08:13, Valentine Sinitsyn wrote:
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

I would say that advertising this pin correctly to the driver is the 
first step. Trying to make the auto-parser treat this pin better would 
be a second step, separate from this patch. Making a new model (if that 
is what you call a "preset") would work as well, and might be easier for 
this particular case, while improving the auto-parser would be better in 
the long run.

Do you agree?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
