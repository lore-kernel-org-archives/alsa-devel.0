From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Mon, 20 Jun 2011 17:52:37 +0100
Message-ID: <20110620165237.GC32056@opensource.wolfsonmicro.com>
References: <csg7ltyo2ntnnwkjy445wvqj.1308577935731@email.android.com>
	<BANLkTin7K_qO3ejJhOswjSjrLVh0cN2_Wg@mail.gmail.com>
	<s5hoc1s4iu3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8AA382453D
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 18:52:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hoc1s4iu3.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, David Henningsson <david.henningsson@canonical.com>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2011 at 05:35:00PM +0200, Takashi Iwai wrote:

> Also, we may consider some way to expose the corelation of the jack
> control element and other mixer elements.  Though, this sounds
> optional to me for the time being.

>From that point of view it'd be much better to do this as part of
exposing the full routing map and positioning of the controls within the
map to applications - there has been some discussion about using the
media controller API to do that within the context of ASoC though not
much work on actually implementing it yet.  This would solve a lot of
problems with figuring out how the card fits together that we have
currently.
