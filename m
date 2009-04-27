From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Driver code with mpc5200 pointer problem.
Date: Mon, 27 Apr 2009 10:16:16 -0400
Message-ID: <9e4733910904270716v289e6d5exaf6e17331786ea11@mail.gmail.com>
References: <9e4733910904260825o68d5b9dndbf92cdbc4a4e48e@mail.gmail.com>
	<alpine.LNX.2.00.0904261838010.25064@eeebox2.perex-int.cz>
	<9e4733910904261114u20e8376ci26a13a5210a4aa0b@mail.gmail.com>
	<20090427092514.GB1760@sirena.org.uk>
	<9e4733910904270650g204d2660y7e3b9ea03446a752@mail.gmail.com>
	<20090427135737.GA20591@sirena.org.uk>
	<9e4733910904270702w317c8c62vbee38230979ad121@mail.gmail.com>
	<20090427140554.GB20591@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id A1C5D24581
	for <alsa-devel@alsa-project.org>;
	Mon, 27 Apr 2009 16:16:18 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id k40so862005wah.16
	for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2009 07:16:17 -0700 (PDT)
In-Reply-To: <20090427140554.GB20591@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 27, 2009 at 10:05 AM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Mon, Apr 27, 2009 at 10:02:47AM -0400, Jon Smirl wrote:
>
>> Is there really a problem with sending the reorg in now? There are
>> only two users of the code and we have both ack'd it.
>
> It's a fairly hefty change for -rc4. =A0From the sounds of it you just
> need to add the constraint?

it is also broken because of the additional requirement of needing to
estimate the current position of the DMA transfer. The changes in
pcm_lib.c have made it non-functional.  When I went into fix those
problems I found a couple more issues.  It's ok for i2s to be broken
in this release, Grant and I both know it is broken and won't ship
anything based on it.

Here's the reorg series on linux-ppc
http://ozlabs.org/pipermail/linuxppc-dev/2009-April/071206.html
I want to do the rename of the globals that Grant suggested.

The pcm_lib.c changes may have broken other embedded drivers too.  And
yes, these other drivers are probably implemented wrong and the
changes in pcm_lib.c exposed their errors. But they will be
non-functional until someone notices and fixes them.

-- =

Jon Smirl
jonsmirl@gmail.com
