From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [ASoC] ASoC on a AT91RM9200 with a tlv320aic23b
	codec
Date: Tue, 15 Jul 2008 09:52:48 +0100
Message-ID: <20080715085244.GK25448@sirena.org.uk>
References: <487BF65F.2040307@videotron.qc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 937CF2417D
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jul 2008 10:52:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <487BF65F.2040307@videotron.qc.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Simon Tremblay <bidou@videotron.qc.ca>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 14, 2008 at 08:59:11PM -0400, Simon Tremblay wrote:

> I think there is a driver for tlv320 (looks like a generic driver for 
> tlv320xxx) in dev branch. Anybody knows if this driver works with 
> tlv320aic23b?

The tlv320 driver in the development branch is for (accoding to in-code
comments the TLV320AIC24K and TLV320AIC14K and isn't really a generic
one, unfortunately.  There are drivers for the tlv320aic3x and the
tlv320aic26 (the latter has been posted to the list a few times in the
past few days) - I don't know how similar either of those are.

> I saw this driver isn't tagged in any kernel version (currently I use 
> 2.6.24 and tlv320.c and tlv320.h aren't in the codecs directory). Is it 
> because the driver isn't tested yet?

It needs some updates for at least coding style and renaming to
something more specific to the chips it controls.  Unfortunately the
original author appears not to be working on it any more.
