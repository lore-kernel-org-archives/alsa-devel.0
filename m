From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: [PATCH][ASoC v2] Update Freescale MPC8610HPCD
	fabric driver to support multiple codecs
Date: Fri, 13 Jun 2008 10:36:28 -0400
Message-ID: <9e4733910806130736r3660c622sb75666cb561986d9@mail.gmail.com>
References: <1213315299-30592-1-git-send-email-timur@freescale.com>
	<9e4733910806121957y3a8a15dawb50af2d2bb0d7d0b@mail.gmail.com>
	<20080613134206.GA29575@rakim.wolfsonmicro.main>
	<9e4733910806130710k38c45e18p29188e1426851339@mail.gmail.com>
	<4852837C.6050401@freescale.com>
	<9e4733910806130729u1bdf5159n5fd820e4e644573a@mail.gmail.com>
	<485284F0.1070601@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F4D31037F7
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 16:36:30 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so3622572rvb.32
	for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2008 07:36:28 -0700 (PDT)
In-Reply-To: <485284F0.1070601@freescale.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 6/13/08, Timur Tabi <timur@freescale.com> wrote:
> Jon Smirl wrote:
>
>  > That forces every board to copy/paste the fabric driver and then makes
>  > tweaks to it even if it doesn't need board specific code.
>
>
> Not at all.   There's no reason we can't create a generic fabric driver that
>  does no board-level programming.  I haven't done it because the MPC8610 does
>  need that kind of programming, and it's based on the information I get from the
>  SSI driver.  But you could just as easily take my fabric driver and make it
>  generic.  I don't know who would use it, though.

Doesn't the fact that you needed to modify the fabric driver to create
two PCMs indicate that there is something wrong with the design?
There is one fabric and two ssi devices.


>
>
>  --
>
> Timur Tabi
>  Linux kernel developer at Freescale
>


-- 
Jon Smirl
jonsmirl@gmail.com
