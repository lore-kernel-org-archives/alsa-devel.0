From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Modify mpc5200 AC97 driver to use V9 of
	spin_event_timeout()
Date: Tue, 26 May 2009 19:38:39 -0500
Message-ID: <ed82fe3e0905261738u655f6f5at2351341a0a5e50d5@mail.gmail.com>
References: <20090527002530.16740.62502.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 7720C2445F
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 02:38:40 +0200 (CEST)
Received: by qyk1 with SMTP id 1so5708296qyk.16
	for <alsa-devel@alsa-project.org>; Tue, 26 May 2009 17:38:39 -0700 (PDT)
In-Reply-To: <20090527002530.16740.62502.stgit@terra>
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
Cc: grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Tue, May 26, 2009 at 7:25 PM, Jon Smirl <jonsmirl@gmail.com> wrote:

> - =A0 =A0 =A0 spin_event_timeout(0, 10, 0, rc);
> + =A0 =A0 =A0 spin_event_timeout(0, 10, 0);
> =A0 =A0 =A0 =A0out_8(&regs->op0, MPC52xx_PSC_OP_RES);
> - =A0 =A0 =A0 spin_event_timeout(0, 50, 0, rc);
> + =A0 =A0 =A0 spin_event_timeout(0, 50, 0);

Jon, I'm still hoping you'll explain why you're not using udelay() here.

-- =

Timur Tabi
Linux kernel developer at Freescale
