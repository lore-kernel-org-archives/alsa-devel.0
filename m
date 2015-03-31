From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2 0/4] ASoC: constification and random
	cleanups
Date: Tue, 31 Mar 2015 19:43:09 +0200
Message-ID: <20150331174309.GK17728@pengutronix.de>
References: <1427813339-23817-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150331161924.GT2869@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id A8EF3264F0A
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 19:43:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20150331161924.GT2869@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Fabian Frederick <fabf@skynet.be>, kernel@pengutronix.de, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On Tue, Mar 31, 2015 at 05:19:24PM +0100, Mark Brown wrote:
> On Tue, Mar 31, 2015 at 04:48:55PM +0200, Uwe Kleine-K=F6nig wrote:
> =

> > Mark said he already took patch 3, but that should not be a problem.
> =

> Please don't do this, it's confusing to get already applied patches
> resent and adds to the mail volume.
ok, I was lazy here.

> > Patch 4 applied just fine to next, so this is just a resend.
> =

> This patch appears to be unrelated to the rest of the series :(
>From my point of view it is related. Initially this series was a single
patch that made all of_device_ids const for ASoC. Then I split out the
fsi changes because they were too heavy for a multi-driver patch. While
doing this I noticed the license mismatch.

I assume I shouldn't resend patch 4 separately :-)

Best regards
Uwe

-- =

Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
