From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: omap: rx51: Enable McBSP2 sidetone
Date: Wed, 09 Mar 2011 11:55:43 +0000
Message-ID: <1299671743.3360.89.camel@odin>
References: <1299662700-25220-1-git-send-email-jhnikula@gmail.com>
	<20110309101157.GA1225@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id D71381039A1
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 12:55:46 +0100 (CET)
Received: by wwj40 with SMTP id 40so380230wwj.20
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 03:55:46 -0800 (PST)
In-Reply-To: <20110309101157.GA1225@sirena.org.uk>
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

On Wed, 2011-03-09 at 10:11 +0000, Mark Brown wrote:
> On Wed, Mar 09, 2011 at 11:25:00AM +0200, Jarkko Nikula wrote:
> > McBSP sidetone is needed in telephony applications. McBSP sidetone is a
> > configurable FIR filter that forms a loopback from McBSP input to output.
> > This patch enables the McBSP2 sidetone ALSA controls so that it can be used
> > on Nokia RX-51/N900.
> 
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Applied.

Thanks

Liam
