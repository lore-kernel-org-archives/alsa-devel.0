From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v8 3/3 RESEND] ASoC: da7210: Add support
 for line input and mic
Date: Mon, 2 Jan 2012 12:58:15 +0000
Message-ID: <20120102125815.GI4300@opensource.wolfsonmicro.com>
References: <1325505952.12508.12.camel@matrix>
	<20120102120024.GH2899@opensource.wolfsonmicro.com>
	<1325506569.12508.15.camel@matrix>
	<20120102121117.GI2899@opensource.wolfsonmicro.com>
	<1325508002.12508.30.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B1E16103913
	for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2012 13:58:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1325508002.12508.30.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, lrg <lrg@ti.com>, "kuninori.morimoto.gx" <kuninori.morimoto.gx@renesas.com>, David Dajun Chen <david.chen@diasemi.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 02, 2012 at 06:10:02PM +0530, Ashish Chavan wrote:

> I see, I was not aware of this norm. I just thought that not changing
> the subject line may help in identifying multiple submissions of the
> same patch.

No, that's what the human readable portion is for.

> BTW, should the version info be also dropped in case if we consider this
> as a new, independent patch? Because many of the version increments were
> just because of changes in other, earlier patches in the series.

Personally I find the versioning information a waste of time in the
first place, it just obscures more of the subject line in mail readers.
A patch is going to be considered on its merits no matter how many times
it's been sent before, having a version number is often just depressing
(as with those PMIC patches).
