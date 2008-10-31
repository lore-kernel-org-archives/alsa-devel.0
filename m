From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASOC deprecated warning
Date: Fri, 31 Oct 2008 10:41:42 +0000
Message-ID: <20081031104142.GA7516@sirena.org.uk>
References: <9e4733910810301222v360ecf8aqbbead50759a2b844@mail.gmail.com>
	<20081030195107.GA13678@sirena.org.uk>
	<9e4733910810301257t159c1b20t3a0414b55410dd7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 8270D2444C
	for <alsa-devel@alsa-project.org>; Fri, 31 Oct 2008 11:41:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <9e4733910810301257t159c1b20t3a0414b55410dd7f@mail.gmail.com>
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
Cc: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 30, 2008 at 03:57:33PM -0400, Jon Smirl wrote:
> On Thu, Oct 30, 2008 at 3:51 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> > you want.  Otherwise I'd suggest taking it up with the people
> > maintaining the compiler infrastructure - there's no way to warn on use
> > of an API without also warning on the export of the API, which isn't
> > ideal.

> sysfs has a config attribute for including legacy APIs. If it isn't
> set they compile out.

As I suggested, if you'd like to see a similar configuration option for
deprecated APIs the best people to take it up with would probably be the
people who maintain the compiler infrastructure which is used to
generate the deprecation warning so we can have something central for
this.
