From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH V4 3/5] AC97 driver for mpc5200
Date: Mon, 25 May 2009 22:41:23 -0500
Message-ID: <ed82fe3e0905252041u367cac2fk80c9316c0236e340@mail.gmail.com>
References: <20090525221406.21370.30326.stgit@terra>
	<20090525221511.21370.81405.stgit@terra>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 1101D24508
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 05:41:24 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 4so1915568qwk.56
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2009 20:41:24 -0700 (PDT)
In-Reply-To: <20090525221511.21370.81405.stgit@terra>
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

On Mon, May 25, 2009 at 5:15 PM, Jon Smirl <jonsmirl@gmail.com> wrote:

> + =A0 =A0 =A0 spin_event_timeout(1, 3, 0, rc);

Ugh, don't do this.  Just use udelay!

-- =

Timur Tabi
Linux kernel developer at Freescale
