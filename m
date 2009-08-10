From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Implementing sync start
Date: Mon, 10 Aug 2009 13:43:50 +0100
Message-ID: <20090810124350.GB24947@sirena.org.uk>
References: <9e4733910908081116p221e606cma31a95b06d9b5be6@mail.gmail.com>
	<9e4733910908082007n5d2e7f48g453b1f2e3c6eb23e@mail.gmail.com>
	<9e4733910908091913j63debfefja44e8e04e278e087@mail.gmail.com>
	<9e4733910908091919o617eb1b8r44436cd87a6873ff@mail.gmail.com>
	<4A7FCF0A.1000806@ladisch.de>
	<9e4733910908100445u3ea02395y9dc39b73ad41cb6b@mail.gmail.com>
	<4A800B47.6020201@ladisch.de>
	<9e4733910908100524w510ba17ep2d6482cdfad57597@mail.gmail.com>
	<4A8012B4.5000009@ladisch.de>
	<9e4733910908100541y495f491cy7a25351a8c36f3dd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0690D10387F
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 14:43:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <9e4733910908100541y495f491cy7a25351a8c36f3dd@mail.gmail.com>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 10, 2009 at 08:41:20AM -0400, Jon Smirl wrote:
> On Mon, Aug 10, 2009 at 8:29 AM, Clemens Ladisch<clemens@ladisch.de> wrote:

> > Linked substreams are handled by ALSA's kernel part with a loop inside
> > a spinlock.

> Linking via  snd_soc_dai_link or is there another way to link?

That's completely unrelated - each link there just defines a CODEC<->CPU
connection.
