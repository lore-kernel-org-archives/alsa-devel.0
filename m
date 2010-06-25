From: Timur Tabi <timur@freescale.com>
Subject: Re: ALSA SoC device tree bindings
Date: Fri, 25 Jun 2010 08:21:45 -0500
Message-ID: <AANLkTimb38wmXv6yOp46cdwe6LcZdDOpHl_xLPxnAXYo@mail.gmail.com>
References: <201006232030.14138.jeremy.kerr@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 32C93103821
	for <alsa-devel@alsa-project.org>;
	Fri, 25 Jun 2010 15:22:18 +0200 (CEST)
Received: by vws11 with SMTP id 11so615096vws.38
	for <alsa-devel@alsa-project.org>; Fri, 25 Jun 2010 06:22:15 -0700 (PDT)
In-Reply-To: <201006232030.14138.jeremy.kerr@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jeremy Kerr <jeremy.kerr@canonical.com>
Cc: devicetree-discuss@lists.ozlabs.org, kernel-team@lists.ubuntu.com, linaro-dev@lists.linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 23, 2010 at 7:30 AM, Jeremy Kerr <jeremy.kerr@canonical.com> wrote:

> - if you have any comments or suggestions, please let me know, or add to the
> page (or the discussion for the page). I intend for this document to become a
> more formal specification, but we still have a way to go before that happens.

Please consider using the MPC8610 HPCD board as a reference
implementation, instead of i.MX boards.  This is a PowerPC board that
has long since support OF bindings for ASoC drivers, so the code is
more robust.  ARM only recently got basic OF support, and AFAIK, none
of the audio drivers support it.

-- 
Timur Tabi
Linux kernel developer at Freescale
