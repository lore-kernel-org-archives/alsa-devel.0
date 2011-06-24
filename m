From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ALSA SoC on Android problems
Date: Fri, 24 Jun 2011 13:34:14 +0100
Message-ID: <20110624123413.GA19804@sirena.org.uk>
References: <4E035DCA.9010409@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 92251103AFD
	for <alsa-devel@alsa-project.org>;
	Fri, 24 Jun 2011 14:34:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E035DCA.9010409@csr.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marco Sinigaglia <marco.sinigaglia@csr.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 23, 2011 at 04:37:46PM +0100, Marco Sinigaglia wrote:

> I am quite sure that the  kernel does not find/setup the WM9714. 
> Assuming that is the kernel that has to configure it, do I have to setup 
> something?
> I can see that, on linux-2.6.35/sound/soc/codecs/wm9713.c, the 
> wm9713_soc_probe function is not call. Nevertheless, the smdk_wm9713.c 
> does run the smdk_init without errors.

You need to write a machine driver for your board and you need to
ensure that all the ASoC devices are registered on your system.
Defining DEBUG at the top of soc-core.c will make ASoC much more verbose
about the probe process.
