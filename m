From: James Courtier-Dutton <james.dutton@gmail.com>
Subject: Re: ALSA layer in Linux 2.6.18 and OSS
Date: Mon, 16 Feb 2009 11:04:29 +0000
Message-ID: <ad2655cb0902160304i33439a6fie7c029d918fe6af1@mail.gmail.com>
References: <49991BCE.40400@einfochips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f19.google.com (mail-fx0-f19.google.com
	[209.85.220.19]) by alsa0.perex.cz (Postfix) with ESMTP id 15CFA244B3
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 12:07:58 +0100 (CET)
Received: by fxm12 with SMTP id 12so3833456fxm.8
	for <alsa-devel@alsa-project.org>; Mon, 16 Feb 2009 03:07:57 -0800 (PST)
In-Reply-To: <49991BCE.40400@einfochips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Viral Mehta <viral.mehta@einfochips.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/2/16 Viral Mehta <viral.mehta@einfochips.com>:
> Hi All,
>
>
> When I booted my kernel, I found that there was no "/dev/dsp" device and
> so my application was not able to run. The application opens "/dev/dsp"
> device first and then does other things.
>

/dev/dsp is the OSS API. So an install without OSS will not have /dev/dsp.
An application that supports alsa will link to libasound.
If you have an OSS application that you want to work with ALSA, you
need to add the ALSA OSS emulation layer.
