From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC PATCH 2/3] MIPS: Alchemy: DB1200 AC97+I2S
	audio support.
Date: Tue, 3 Nov 2009 16:35:18 +0100
Message-ID: <20091103153518.GA5999@linux-mips.org>
References: <1257193305-29996-1-git-send-email-manuel.lauss@gmail.com>
	<1257193305-29996-2-git-send-email-manuel.lauss@gmail.com>
	<20091103153040.GC1742@linux-mips.org>
	<f861ec6f0911030730k53b2b921kddc8c67266846af2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eddie.linux-mips.org (eddie.linux-mips.org [78.24.191.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 3A874103904
	for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2009 16:33:51 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:49229 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org with ESMTP
	id S1493388AbZKCPdu (ORCPT <rfc822;alsa-devel@alsa-project.org>);
	Tue, 3 Nov 2009 16:33:50 +0100
Content-Disposition: inline
In-Reply-To: <f861ec6f0911030730k53b2b921kddc8c67266846af2@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Manuel Lauss <manuel.lauss@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 03, 2009 at 04:30:26PM +0100, Manuel Lauss wrote:

> =

> On Tue, Nov 3, 2009 at 4:30 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> > On Mon, Nov 02, 2009 at 09:21:44PM +0100, Manuel Lauss wrote:
> >
> >> Machine driver for DB1200 AC97 and I2S audio systems, intended as a
> >> proper reference asoc machine for Alchemy-based systems.
> >> AC97/I2S can be selected at boot time by setting switch S6.7
> >>
> >> Cc: alsa-devel@alsa-project.org
> >> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> >> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
> >> ---
> >> Depends on patch "ASoC: au1x: convert to platform drivers" in
> >> Mark Brown's asoc tree to actually work.
> >
> > Queued for 2.6.33. =A0I've not seen the dependency but I hope there is =
no
> > harm in getting things merged out of order?
> =

> You just won't get any sound if the other patch isnt applied first,
> no build failures of oopses.

With Mark's approval I'd not mind merging the other patch through the MIPS
tree as well then.

  Ralf
