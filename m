From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC: SAMSUNG: About I2S_v4 support
Date: Wed, 3 Mar 2010 11:21:23 +0000
Message-ID: <20100303112123.GA14190@rakim.wolfsonmicro.main>
References: <1b68c6791003030032n7de8a0d8t5395a0a260d92b19@mail.gmail.com>
	<20100303095412.GA2581@opensource.wolfsonmicro.com>
	<1b68c6791003030310n64f22a5cse1aa3b59081d782e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A056310380C
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 12:21:24 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791003030310n64f22a5cse1aa3b59081d782e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Ben Dooks <ben-linux@fluff.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 03, 2010 at 08:10:32PM +0900, jassi brar wrote:
> On Wed, Mar 3, 2010 at 6:54 PM, Mark Brown

> > Please also remember that we need to get the clock API changes to allow
> > the driver to start. =A0I've been chasing patches for these for the past
> > couple of kernel releases but it's not ideal that I need to do this.

> I guess whatever needs to be done for the release version, will be done.
> Though I am not sure if I should get into modifying s3c-clock support for
> the sake of s3c-audio.

The stuff that needs doing is the really basic stuff like registering
CLKAUDIO2 so the driver can request it, not any substantial refactoring
of the clocking code.
