From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] WM8580 DAI: Debugged
Date: Mon, 14 Sep 2009 13:06:48 +0100
Message-ID: <20090914120647.GB1260@rakim.wolfsonmicro.main>
References: <1252742737-21925-1-git-send-email-jassisinghbrar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3CEEE103812
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Sep 2009 14:06:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1252742737-21925-1-git-send-email-jassisinghbrar@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassisinghbrar@gmail.com
Cc: alsa-devel@alsa-project.org, kgene.kim@samsung.com, Jassi <jassi.brar@samsung.com>, jsgood.yang@samsung.com, ilho215.lee@samsung.com, thomas.ab@samsung.com, ki0351.kim@samsung.com
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 12, 2009 at 05:05:37PM +0900, jassisinghbrar@gmail.com wrote:
> From: Jassi <jassi.brar@samsung.com>
> 
> Debugged improper definition of 'struct snd_soc_dai wm8580_dai'
> Also, implemented various clock sourcing options for WM8580 blocks.

There's several problems here which mean I'm unable to apply the patch.  
The biggest issue, which seems to apply to many of your patches (not
just the ones you've sent to me), is that you've combined several
unrelated changes into a single patch.  This is generally considered to
be poor practice.  It makes patches harder to review and apply,
especially when parts need to be applied in different places, and makes
the history less useful.

It would also be very helpful if you could devote more effort to your
changelogs - for example, you have not explained what the issue you
believe you are addressing in the DAI definition is.  Looking at the
patch I suspect there has been a misunderstanding somewhere along the
line.
