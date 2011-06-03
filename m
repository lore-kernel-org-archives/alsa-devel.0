From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Need general idea how to architect driver for
 multi-codec board
Date: Fri, 3 Jun 2011 09:48:15 +0100
Message-ID: <20110603084814.GB21286@opensource.wolfsonmicro.com>
References: <BANLkTi=Fi_4nCP7A3Jd9C=4N_FTijOwGdw@mail.gmail.com>
	<20110511175021.GB22798@sirena.org.uk>
	<BANLkTi=arRRqPEDS9S=-ynM_1d8N_A=d+w@mail.gmail.com>
	<20110527012756.GA26768@sirena.org.uk>
	<BANLkTinM_MigPxzY4WCBZhjRPwuV15b9gQ@mail.gmail.com>
	<20110528013355.GD5971@opensource.wolfsonmicro.com>
	<BANLkTinhMP143K5mAPPPc_R6N7Wxk8zZ3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 19C7F10391B
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 10:48:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTinhMP143K5mAPPPc_R6N7Wxk8zZ3g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 01, 2011 at 03:17:10PM -0700, Caleb Crome wrote:

>   Sorry to keep on this, but I'm really wedged.  I can't tell if I'm trying
> to break new ground, or if I just don't know what I'm doing :-)  Or both
> perhaps.

Like I said in my last mail you're probably trying to break new ground
here.  You're trying to bind all the CODECs together and treat them as
one digital interface, currently the code does a series of point to
point links multiplexed on a bus only.

> I've got my multi-codec card instantiating (only 4 codecs here for
> simplicity -- there are really 8 total)

> # insmod tlv320aic3x_se.ko   # <--- my custom version of aic3x driver.

That's not a good sign...  If you've modified the driver you probably
want to look into submitting your modifications back upstream.
