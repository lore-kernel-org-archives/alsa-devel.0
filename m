From: Daniel Mack <zonque@gmail.com>
Subject: Re: Out of tree driver for hiface
Date: Wed, 07 Nov 2012 01:50:43 +0100
Message-ID: <5099B063.60801@gmail.com>
References: <CACckToVxqMdQx_ER+ErsyJech8EVx2k8U_Ps5qzymFL1bd3-FA@mail.gmail.com>
 <CACckToX+BVfTisKUZfkVe43ZE5S4k+QAwWwAhdzrb_YjwmP+QQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com
 [209.85.212.179])
 by alsa0.perex.cz (Postfix) with ESMTP id BE203264EEE
 for <alsa-devel@alsa-project.org>; Wed,  7 Nov 2012 01:50:45 +0100 (CET)
Received: by mail-wi0-f179.google.com with SMTP id hq7so810280wib.2
 for <alsa-devel@alsa-project.org>; Tue, 06 Nov 2012 16:50:45 -0800 (PST)
In-Reply-To: <CACckToX+BVfTisKUZfkVe43ZE5S4k+QAwWwAhdzrb_YjwmP+QQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Grant Diffey <gdiffey@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 06.11.2012 23:32, Grant Diffey wrote:
> Were either of you aware of: https
> <https://github.com/panicking/snd-usb-asyncaudio>://

I wasn't - thanks for the pointer.

> Could ever be merged/incorporated into mainline?
>
> Does it contain too much in common with snd-usb-audio requiring merging
> into that to go into mainline?

That driver currently doesn't care to integrate into the snd-usb generic
driver, but it could live within mainline as propietary thing. If anyone
with access to the hardware and sufficient free time wants to prepare
patches, they can be reviewed :)

Would you like to contact the author maybe?


Daniel
