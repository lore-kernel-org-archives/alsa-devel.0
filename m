From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Modify mpc5200 AC97 driver to use V9 of
	spin_event_timeout()
Date: Tue, 26 May 2009 22:00:51 -0600
Message-ID: <fa686aa40905262100v64a01d41q65ff39ad953305a3@mail.gmail.com>
References: <20090527002530.16740.62502.stgit@terra>
	<ed82fe3e0905261738u655f6f5at2351341a0a5e50d5@mail.gmail.com>
	<9e4733910905261744j3589ace8wd427ef8a5998eccf@mail.gmail.com>
	<fa686aa40905262048ma2d5e12s907c489974343280@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 5DC44245AA
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 06:01:12 +0200 (CEST)
Received: by gxk2 with SMTP id 2so8259077gxk.8
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2009 21:01:11 -0700 (PDT)
In-Reply-To: <fa686aa40905262048ma2d5e12s907c489974343280@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, Timur Tabi <timur@freescale.com>, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2009 at 9:48 PM, Grant Likely <grant.likely@secretlab.ca> w=
rote:
> First, udelay just burns time, and if the delay is too large, then the
> it is wasting time that could be used for something else. =A0That being
> said, it needs to be balanced with the context switch overhead. =A0If
> the udelay() is less than double the context switch time, then the
> overhead is greater than the time spent spinning.

BTW, lmbench lat_ctx test case tells me that context switch latency is
measured somewhere around 30 to 60 us for user space processes
sleeping on a file descriptor.  That will be lower for kernel threads
since there is no syscall overhead to account for.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
