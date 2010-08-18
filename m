From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: aplay -l messes up terminal settings.
Date: Wed, 18 Aug 2010 10:17:39 +0800
Message-ID: <AANLkTinmBmPGnbGWMQO-siF0kFF60QDUg=mJmvp0N_+S@mail.gmail.com>
References: <4C6B3BD7.2070206@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id 757D924501
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Aug 2010 04:17:39 +0200 (CEST)
Received: by ewy21 with SMTP id 21so48756ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 17 Aug 2010 19:17:39 -0700 (PDT)
In-Reply-To: <4C6B3BD7.2070206@audioscience.com>
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

2010/8/18 Eliot Blennerhassett <linux@audioscience.com>

> Hi Jaroslav,
>
> there is something wrong with the last commit to aplay (at least for me
> Gnome terminal 2.29.6).
>
> When I do aplay -l or aplay -L,  my keystrokes are subsequently not
> echoed in the terminal.
>
> regards
>
> Eliot
>
> 73c79ebf26a51a2d9b582a4cae82867873875743 is the first bad commit
> commit 73c79ebf26a51a2d9b582a4cae82867873875743
> Author: Jaroslav Kysela <perex@perex.cz>
> Date:   Thu Jul 15 13:39:14 2010 +0200
>
>    aplay: fix termio settings - return back old c_flag value on exit
>
>    - symptom - ssh client password authentication does not work with
>      the modified terminal settings
>
>    Signed-off-by: Jaroslav Kysela <perex@perex.cz>
>
> :040000 040000 f7624e3b40c38f4bb2ae450b5e94ec938ffddc90
> 33ffa7e2c1729c6e738db25f68deb843a8a67245 M      aplay
>
> --
> Eliot Blennerhassett
> AudioScience Inc.
>

yes,  gnome-terminal 2.24.3 seem freeze after  aplay -l and aplay -L
