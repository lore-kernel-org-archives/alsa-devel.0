From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [RME - hdsp] alsa-lib's hdsp.h out of sync
Date: Wed, 27 Jul 2011 21:42:24 +0200
Message-ID: <20110727194224.GH19500@ltw.loris.tv>
References: <4E304FEE.4000302@drcomp.erfurt.thur.de>
	<s5hd3gv7cj5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D2BC24333
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jul 2011 21:42:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hd3gv7cj5.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jul 27, 2011 at 09:23:58PM +0200, Takashi Iwai wrote:

Hi!

> > While hacking on RPM support for hdspmixer, I've noticed that alsa-lib's
> > hdsp.h doesn't reflect the kernel's hdsp.h: RPM is missing in
> > HDSP_IO_Type.
> > 
> > AFAIK, somebody has to regenerate alsa-lib's hdsp.h, right? Please do
> > so. ;)
> Don't hesitate to volunteer :)

I don't know how to do it. Is this an automatic process? If not, I'll
simply come up with a manually written patch against alsa-lib.


Cheers
