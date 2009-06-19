From: Daniel Chen <seven.steps@gmail.com>
Subject: Re: IDT quirks...where?
Date: Fri, 19 Jun 2009 18:05:48 -0400
Message-ID: <604760770906191505jf8f1134ie406b8bed0ad4e3b@mail.gmail.com>
References: <1245448160.313.510.camel@adam.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 27280246AE
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Jun 2009 00:05:49 +0200 (CEST)
Received: by bwz11 with SMTP id 11so2123230bwz.32
	for <alsa-devel@alsa-project.org>; Fri, 19 Jun 2009 15:05:48 -0700 (PDT)
In-Reply-To: <1245448160.313.510.camel@adam.local.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Williamson <awilliam@redhat.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 19, 2009 at 5:49 PM, Adam Williamson<awilliam@redhat.com> wrote:
> patch_*.c files seems to cover IDT codecs. What's the story with these?
> Where do their quirks go? Does current ALSA have one already? (I did try

Use sound/pci/hda/patch_sigmatel.c::stac92hd71bxx_cfg_tbl[].
