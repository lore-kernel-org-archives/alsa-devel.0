From: Daniel Mack <zonque@gmail.com>
Subject: Re: Setting invalid samplerate
Date: Thu, 19 May 2011 13:36:26 +0200
Message-ID: <BANLkTim0fwy06AMWfqn7Jv7FF+ZDpToT7Q@mail.gmail.com>
References: <4DD27C43.3050509@canonical.com> <s5hfwod5nz0.wl%tiwai@suse.de>
	<4DD4E909.80108@canonical.com> <s5htycr0zuf.wl%tiwai@suse.de>
	<13007c956d1.7109012681098247941.4235053919533621827@zoho.com>
	<4DD4F720.5090706@ladisch.de>
	<1300803426d.8193857618078346392.-5936708198613114653@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f170.google.com (mail-px0-f170.google.com
	[209.85.212.170])
	by alsa0.perex.cz (Postfix) with ESMTP id 938A01039F6
	for <alsa-devel@alsa-project.org>;
	Thu, 19 May 2011 13:36:29 +0200 (CEST)
Received: by pxi19 with SMTP id 19so1801853pxi.29
	for <alsa-devel@alsa-project.org>; Thu, 19 May 2011 04:36:26 -0700 (PDT)
In-Reply-To: <1300803426d.8193857618078346392.-5936708198613114653@zoho.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Torsten Schenk <torsten.schenk@zoho.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Dan Carpenter <error27@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, May 19, 2011 at 1:28 PM, Torsten Schenk <torsten.schenk@zoho.com> wrote:
> That did the job indeed. I still wonder why it worked in so many cases... However, I will soon create a patch and submit it.

Remember to add a "Cc: stable@kernel.org" in the commit log if you
want to have it backported to stable series of the kernel.

Daniel
