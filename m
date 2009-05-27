From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] Modify mpc5200 AC97 driver to use V9 of
	spin_event_timeout()
Date: Tue, 26 May 2009 21:01:00 -0400
Message-ID: <9e4733910905261801p130f50afie2c50d5723192d44@mail.gmail.com>
References: <20090527002530.16740.62502.stgit@terra>
	<ed82fe3e0905261738u655f6f5at2351341a0a5e50d5@mail.gmail.com>
	<9e4733910905261744j3589ace8wd427ef8a5998eccf@mail.gmail.com>
	<ed82fe3e0905261753v1cb9c901i3b66cd903e4adda6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.146])
	by alsa0.perex.cz (Postfix) with ESMTP id EB3AA244BA
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 03:01:01 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so2307572qwk.56
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2009 18:01:01 -0700 (PDT)
In-Reply-To: <ed82fe3e0905261753v1cb9c901i3b66cd903e4adda6@mail.gmail.com>
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
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2009 at 8:53 PM, Timur Tabi <timur@freescale.com> wrote:
> On Tue, May 26, 2009 at 7:44 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>
>> Because Grant didn't want me doing udelay(50) just to delay things in
>> order to give the AC97 controller time to initialize. Your function
>> lets me loop on cpu_relax() for 50us.
>
> But udelay() calls HMT_low(), which is like cpu_relax().

Then why did you need to make your routine that calls cpu_relax()?

I don't know what goes on in the guts of HMT_low() and cpu_relax(),
when you guys decide which one I should use let me know and I can
adjust the patch.

The hardware needs a minimum 50us pause. It doesn't matter if the
pause is more than that. If the CPU has something to keep it busy for
a few milliseconds that's fine.

> --
> Timur Tabi
> Linux kernel developer at Freescale
>

-- 
Jon Smirl
jonsmirl@gmail.com
