From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: SND_SOC_CUSTOM and how to use it
Date: Fri, 24 Jun 2011 13:37:51 +0100
Message-ID: <20110624123751.GB19804@sirena.org.uk>
References: <BANLkTimCRUeVVbVabvc8+UhToEKs=2bw9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 14FC1103B3A
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 14:37:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTimCRUeVVbVabvc8+UhToEKs=2bw9w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raffaele Recalcati <lamiaposta71@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 23, 2011 at 01:13:58PM +0200, Raffaele Recalcati wrote:

> I have this spi commands in a char driver and I suppose I could leave
> the protocol there also for making easier the parameteres tuning from
> user-space and also I could call that commands from
> snd_soc_codec_set_cache_io function.
> Any comment?

Are you writing to actual registers?  If so just make sure whatever the
register format you are using is supported by soc-cache and soc-io and
everything will be fine.  If you're not writing to actual registers then
using the register cache isn't terribly sensible.  If your device has
broken registers for some reason (variably sized registers for example)
then you'll need to open code the I/O in your driver.
