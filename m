From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH v2 1/2] alsa: ASoC driver for s6000 I2S
	interface
Date: Sat, 4 Apr 2009 15:37:41 +0100
Message-ID: <20090404143741.GA6474@sirena.org.uk>
References: <1238266022-27893-1-git-send-email-dg@emlix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E71161037F6
	for <alsa-devel@alsa-project.org>;
	Sat,  4 Apr 2009 16:37:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1238266022-27893-1-git-send-email-dg@emlix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel =?iso-8859-1?Q?Gl=F6ckner?= <dg@emlix.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 28, 2009 at 07:47:01PM +0100, Daniel Gl=F6ckner wrote:
> This patch adds a driver for the I2S interface found on Stretch s6000
> family processors.

This all looks good - the only concern I have is the issue with the
polarity of the clock signals I mentioned in reply to the machine
driver.  The code in the machine driver does make it look like the I2S
driver is using the opposite polarity to that expected.  If that's not
the case then I guess the thing to do is have some documentation in the
machine driver explaining what's going on.

In order to simplify review I've applied both patches to the s6000
branch of my sound git repository.  Please submit any changes as
incremental patches against that rather than as whole new patches.

Thanks!
