From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA 1.0.17rc2 release
Date: Thu, 26 Jun 2008 08:47:34 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806260845190.20581@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0806161121530.1798@tm8103-a.perex-int.cz>
	<20080618235305.bddd8fa2.pochini@shiny.it>
	<Pine.LNX.4.61.0806191110150.1798@tm8103-a.perex-int.cz>
	<20080620230822.49388d19.pochini@shiny.it>
	<Pine.LNX.4.61.0806210927431.1798@tm8103-a.perex-int.cz>
	<1214410574.4303.193.camel@razman>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id C5018245B7
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Jun 2008 08:47:37 +0200 (CEST)
In-Reply-To: <1214410574.4303.193.camel@razman>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tobin Davis <tdavis@dsl-only.net>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 25 Jun 2008, Tobin Davis wrote:

> I am now seeing this script miscompile issue as well on x86 hardware
> (Mandriva 2008 and Ubuntu 8.04 x86 32 bit editions).  The second part of
> the mod-deps.c patch is generating an extra ) for the
> "fm801-tea575x-bool" test and the "usb-caiaq-input" test sections of
> acinclude.m4.

The patch on URL bellow should fix both PPC and parenthesis issues:

http://git.alsa-project.org/?p=alsa-driver.git;a=commitdiff;h=771f0681f80943048e1ccfc41452cf888b71290b;hp=479318b2ea20dd3cd5770df4f4e67d3ea480aac3

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
