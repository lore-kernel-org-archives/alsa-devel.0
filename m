From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: utils - Add support for a dummy
	codec driver.
Date: Tue, 10 Jan 2012 10:53:15 +0000
Message-ID: <1326192795.3944.1.camel@odin>
References: <1326112584-14942-1-git-send-email-lrg@ti.com>
	<20120110044119.GQ30766@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75]) by alsa0.perex.cz (Postfix) with ESMTP id 0F7B524536
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 11:53:20 +0100 (CET)
Received: by werg1 with SMTP id g1so6122820wer.16
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2012 02:53:17 -0800 (PST)
In-Reply-To: <20120110044119.GQ30766@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-01-10 at 04:41 +0000, Mark Brown wrote:
> On Mon, Jan 09, 2012 at 12:36:24PM +0000, Liam Girdwood wrote:
> > This is useful to create dummy codec devices where we need to have some
> > DAI links without a real Codec. e.g. could be used to represent dumb FM,
> > MODEM, etc
> 
> I've applied this but I think we should move it into the CODECs
> directory - I stubbed the platform out in here mostly because there
> isn't a natural place to put a platform driver that's not associated
> with a particular platform.  Does that sound sensible?

yeah, I was 50/50 about this since we do have codecs/ and utils.c. I
don't really mind where it goes.

Liam
