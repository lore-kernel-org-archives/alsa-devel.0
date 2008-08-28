From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH 2/4] ASOC codec: add support for SSM2602
 audio codec in ALSA SoC framework
Date: Thu, 28 Aug 2008 13:44:39 +0200
Message-ID: <20080828134439.0f55e2e4@hyperion.delvare>
References: <1219829968-6431-1-git-send-email-cooloney@kernel.org>
	<1219829968-6431-3-git-send-email-cooloney@kernel.org>
	<20080827105456.GA10834@sirena.org.uk>
	<386072610808272255o7ef18860u29e10727e6e11a11@mail.gmail.com>
	<20080828100615.GA11132@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 85B1E24609
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Aug 2008 13:44:56 +0200 (CEST)
In-Reply-To: <20080828100615.GA11132@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Bryan Wu <cooloney@kernel.org>, Cai <cliff.cai@analog.com>, lrg@kernel.org, Cliff@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Bryan, Mark,

On Thu, 28 Aug 2008 11:06:18 +0100, Mark Brown wrote:
> On Thu, Aug 28, 2008 at 01:55:33PM +0800, Bryan Wu wrote:
> > Yes, I will fix this issue by running checkpatch.pl. And for other API
> > conflicts and I2C interface upgrading stuffs,
> > I will leave them to Cliff.
> 
> OK.  Jean might be willing to do the I2C API conversion for you (I've
> CCed him in).

Sure, I can help with that if needed. OTOH, I've posted patches
converting 2 drivers already [1] [2], and apparently all the codec
drivers follow the same model so it shouldn't be too difficult for
driver authors to do the same on their code. But anyway I'll convert
the remaining drivers as my time permits. The plan is to have
everything converted for kernel 2.6.28 (at which point the old I2C API
will be deprecated.)

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2008-August/010198.html
[2] http://mailman.alsa-project.org/pipermail/alsa-devel/2008-August/010199.html

-- 
Jean Delvare
