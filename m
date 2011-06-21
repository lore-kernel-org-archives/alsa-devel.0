From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: codecs: Max98095: Fix logging of
	hardware	revision.
Date: Tue, 21 Jun 2011 12:55:47 +0100
Message-ID: <20110621115547.GD25032@sirena.org.uk>
References: <1308596072-17158-1-git-send-email-thutt@chromium.org>
	<20110621002322.GE1905@opensource.wolfsonmicro.com>
	<B2150E1E4418E1438554A300EA5040E40DDEC16D42@ITSVLEX06.it.maxim-ic.internal>
	<20110621011038.GA4322@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C8EEE10392A
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Jun 2011 13:55:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110621011038.GA4322@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Hsiang <Peter.Hsiang@maxim-ic.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Taylor Hutt <thutt@chromium.org>, Olof Johansson <olofj@chromium.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 21, 2011 at 02:10:39AM +0100, Mark Brown wrote:
> On Mon, Jun 20, 2011 at 05:43:58PM -0700, Peter Hsiang wrote:

> > I checked with hardware engineering and was told 0x40=RevA, 0x41=RevB..

> > Would a raw value or the use of a 0x3F bit mask be more acceptable?

> I don't mind (though it does seem like the high bit isn't part of the
> actual data), it was just that it's a common error to assume that die
> revisions and package revisions correspond directly.

This means if you're OK with it I can apply the patch as-is, BTW.
