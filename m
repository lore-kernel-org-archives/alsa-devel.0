From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH RFC 1/1] ASoC: WL1273 FM Radio: Eliminate
 unnecessary error return value.
Date: Fri, 10 Sep 2010 12:29:38 +0100
Message-ID: <20100910112937.GD7259@rakim.wolfsonmicro.main>
References: <1284104490-11226-1-git-send-email-matti.j.aaltonen@nokia.com>
	<1284104490-11226-2-git-send-email-matti.j.aaltonen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 741AE10398C
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 13:29:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1284104490-11226-2-git-send-email-matti.j.aaltonen@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 10, 2010 at 10:41:30AM +0300, Matti J. Aaltonen wrote:
> With this change it's not a error to call wl1273_set_audio_route
> when the codec is active if the new routing value is the same
> as the current active setting.
> 
> Signed-off-by: Matti J. Aaltonen <matti.j.aaltonen@nokia.com>

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
