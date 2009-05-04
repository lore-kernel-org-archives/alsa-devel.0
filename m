From: Timur Tabi <timur@freescale.com>
Subject: Re: dmix and mmap
Date: Mon, 4 May 2009 11:57:20 -0500
Message-ID: <ed82fe3e0905040957l13e53319j57ddd1c1de902f92@mail.gmail.com>
References: <bb6204720904300810ma174b6cn825f8565c0b694c0@mail.gmail.com>
	<20090430151301.GA27605@sirena.org.uk>
	<bb6204720904301229q3b0b93eao28563ec7bdef73cb@mail.gmail.com>
	<20090501113240.GF6975@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qy0-f103.google.com (mail-qy0-f103.google.com
	[209.85.221.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 37183243CE
	for <alsa-devel@alsa-project.org>;
	Mon,  4 May 2009 18:57:22 +0200 (CEST)
Received: by qyk1 with SMTP id 1so7434839qyk.16
	for <alsa-devel@alsa-project.org>; Mon, 04 May 2009 09:57:20 -0700 (PDT)
In-Reply-To: <20090501113240.GF6975@sirena.org.uk>
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
Cc: Gabriel Johnson <johnsoga@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, May 1, 2009 at 6:32 AM, Mark Brown <broonie@sirena.org.uk> wrote:
> I know that there were some problems with PowerPC memory access,
> unfortunately I don't know any specifics or if these issues are fixed in
> current kernels. =A0Searching for postings by Takashi Iwai on the PowerPC
> kernel lists might turn something up.

The PowerPC MPC8610 drivers enable mmap support, and it seems to work,
but that chip has a coherent MMU.  I've never done a definitive test
that it works, though.  What's the easiest way to test mmap?

-- =

Timur Tabi
Linux kernel developer at Freescale
