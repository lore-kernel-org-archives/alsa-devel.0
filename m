From: Grant Diffey <gdiffey@gmail.com>
Subject: Re: [PATCH 0/6] snd-usb endpoint rework, version 7
Date: Fri, 13 Apr 2012 09:59:15 +1000
Message-ID: <CACckToUX5iLjbdtjsEFOPk1uBw63EBROe=bj9qokaczB6P5LrQ@mail.gmail.com>
References: <1334231475-20980-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f173.google.com (mail-wi0-f173.google.com
	[209.85.212.173])
	by alsa0.perex.cz (Postfix) with ESMTP id 98D951043FB
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Apr 2012 01:59:15 +0200 (CEST)
Received: by wibhq7 with SMTP id hq7so4899952wib.2
	for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2012 16:59:15 -0700 (PDT)
In-Reply-To: <1334231475-20980-1-git-send-email-zonque@gmail.com>
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
Cc: tiwai@suse.de, blablack@gmail.com, alsa-devel@alsa-project.org, clemens@ladisch.de, linuxaudio@showlabor.de
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 12, 2012 at 9:51 PM, Daniel Mack <zonque@gmail.com> wrote:

> Here's the 7th iteration of patches that reimplement the streaming logic of
> the ALSA USB audio driver.
>
> There were some bugs reportes by Felix and Grant, which have been resolved.
>
> More testing is definitely important, but maybe the code will get a wider
> test coverage when merged to the development tree?
>

So I've also tested this against the current -rt head and can report that
it solves the clicking problem with playback there as well.

Grant.
