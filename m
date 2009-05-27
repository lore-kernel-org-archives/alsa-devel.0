From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH V2] Modify mpc5200 AC97 driver to use V9 of
	spin_event_timeout()
Date: Wed, 27 May 2009 06:39:54 -0500
Message-ID: <ed82fe3e0905270439h4a068564keeb6c0905e958d2a@mail.gmail.com>
References: <20090527043018.4667.94590.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D10A246F5
	for <alsa-devel@alsa-project.org>;
	Wed, 27 May 2009 13:39:55 +0200 (CEST)
Received: by qyk1 with SMTP id 1so6018803qyk.16
	for <alsa-devel@alsa-project.org>; Wed, 27 May 2009 04:39:54 -0700 (PDT)
In-Reply-To: <20090527043018.4667.94590.stgit@terra>
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

On Tue, May 26, 2009 at 11:30 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> The function signature for spin_event_timeout() has changed in version V9.
> Adjust the mpc5200 AC97 driver to use the new function.
> v2 - switch back to udelay() for fixed timeouts.
>
> Signed-off-by: Jon Smirl <jonsmirl@gmail.com>

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
