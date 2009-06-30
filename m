From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97
	driver
Date: Mon, 29 Jun 2009 20:26:12 -0400
Message-ID: <9e4733910906291726h5cd5bdf8ve7e946aef855ac07@mail.gmail.com>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f185.google.com (mail-qy0-f185.google.com
	[209.85.221.185])
	by alsa0.perex.cz (Postfix) with ESMTP id AB58F2496E
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Jun 2009 02:26:14 +0200 (CEST)
Received: by qyk15 with SMTP id 15so657972qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2009 17:26:13 -0700 (PDT)
In-Reply-To: <20090629234214.12670.9082.stgit@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 29, 2009 at 7:42 PM, Grant Likely<grant.likely@secretlab.ca> wr=
ote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> AC97 bus register read/write hooks need to provide locking, but the
> mpc5200-psc-ac97 driver does not. =A0This patch adds a mutex around
> the register access routines.

Does your touchscreen driver use this mutex? Or was this mutex needed
just for the AC97 driver?


-- =

Jon Smirl
jonsmirl@gmail.com
