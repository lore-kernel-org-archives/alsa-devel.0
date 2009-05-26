From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V4 3/5] AC97 driver for mpc5200
Date: Mon, 25 May 2009 21:47:24 -0600
Message-ID: <fa686aa40905252047g6c88efa9t2b9b864f2d2023f9@mail.gmail.com>
References: <20090525221406.21370.30326.stgit@terra>
	<20090525221511.21370.81405.stgit@terra>
	<ed82fe3e0905252041u367cac2fk80c9316c0236e340@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f158.google.com (mail-gx0-f158.google.com
	[209.85.217.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 0BD5C2454A
	for <alsa-devel@alsa-project.org>;
	Tue, 26 May 2009 05:47:44 +0200 (CEST)
Received: by gxk2 with SMTP id 2so6912902gxk.8
	for <alsa-devel@alsa-project.org>; Mon, 25 May 2009 20:47:44 -0700 (PDT)
In-Reply-To: <ed82fe3e0905252041u367cac2fk80c9316c0236e340@mail.gmail.com>
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
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

On Mon, May 25, 2009 at 9:41 PM, Timur Tabi <timur@freescale.com> wrote:
> On Mon, May 25, 2009 at 5:15 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>
>> + =A0 =A0 =A0 spin_event_timeout(1, 3, 0, rc);
>
> Ugh, don't do this. =A0Just use udelay!

heh; indeed.  My objection to udelay is that it burns cycles it the
test loop that could be used to decide whether or not the loop is
complete.  Not an issue when the explicit goal is to burn a fixed
number of cycles.

g.

-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
