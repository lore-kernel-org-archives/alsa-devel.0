From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v4 2/2] ASoC: Davinci: Add audio codec
	support for DM365 EVM
Date: Mon, 14 Sep 2009 12:21:10 -0700
Message-ID: <87skep2uzd.fsf@deeprootsystems.com>
References: <1251927239-3734-1-git-send-email-miguel.aguilar@ridgerun.com>
	<20090902220420.GC4495@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f202.google.com (mail-px0-f202.google.com
	[209.85.216.202])
	by alsa0.perex.cz (Postfix) with ESMTP id 007B824354
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Sep 2009 21:21:16 +0200 (CEST)
Received: by pxi40 with SMTP id 40so2704664pxi.5
	for <alsa-devel@alsa-project.org>; Mon, 14 Sep 2009 12:21:14 -0700 (PDT)
In-Reply-To: <20090902220420.GC4495@sirena.org.uk> (Mark Brown's message of
	"Wed\, 2 Sep 2009 23\:04\:20 +0100")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com, diego.dompe@ridgerun.com, alsa-devel@alsa-project.org, nsnehaprabha@ti.com, todd.fischer@ridgerun.com, miguel.aguilar@ridgerun.com
List-Id: alsa-devel@alsa-project.org

Mark Brown <broonie@opensource.wolfsonmicro.com> writes:

> On Wed, Sep 02, 2009 at 03:33:59PM -0600, miguel.aguilar@ridgerun.com wrote:
>> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
>
>> This patch enables tlv320aic3101 support on DM365 EVM and
>> it was tested on DM365 EVM rev c.
>
>> Note: this patch was created based on temp/asoc branch.
>
> This is OK.  Kevin, will you apply the arch/arm side of this for 2.6.32?
> If so I'll apply the ASoC side - I'd rather not have one without the
> other in case of confusion from the Kconfig text.  Otherwise I'll hold
> off until after the merge window.

I think I'll wait for the next merge window for this one.  It's a bit
late for the current merge window.

Kevin
