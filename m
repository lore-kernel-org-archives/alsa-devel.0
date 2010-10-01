From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: namehint: Evaluate more possibilities for hw
	devices
Date: Fri, 1 Oct 2010 17:08:16 +0800
Message-ID: <AANLkTi=fb6xACkYSDc9Pa4N_ABiN7DDNpe3woVT7+Mxt@mail.gmail.com>
References: <4CA4B6BF.3080503@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6F4FE1039ED
	for <alsa-devel@alsa-project.org>;
	Fri,  1 Oct 2010 11:08:16 +0200 (CEST)
Received: by eye27 with SMTP id 27so1217356eye.38
	for <alsa-devel@alsa-project.org>; Fri, 01 Oct 2010 02:08:16 -0700 (PDT)
In-Reply-To: <4CA4B6BF.3080503@aknet.ru>
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

2010/10/1 Stas Sergeev <stsp@aknet.ru>

>  Hi Jaroslav.
>
> I updated the alsa-lib from git, and "aplay -L"
> no longer shows some PCMs it used to list before.
> I tracked this down to this commit:
> ---
> commit 97d25c0766405453d3c298bd51dd4916121a4f6a
> Author: Jaroslav Kysela <perex@perex.cz>
> Date:   Fri Aug 20 10:31:17 2010 +0200
>
>    namehint: Evaluate more possibilities for hw devices
> ---
>
> Attached are the outputs before and after the commit.
> So why some devices are now missing?
>
>
it seem that only occur when card with one playback device or one capture
device

(e.g. snd-dummy also has this problem but snd-aloop does not )
