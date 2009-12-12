From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Two codecs using the same I2S bus
Date: Sat, 12 Dec 2009 18:05:22 +0000
Message-ID: <20091212180521.GA3092@sirena.org.uk>
References: <4B223B13.8050502@langendorff.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id F3EF624790
	for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2009 19:05:25 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B223B13.8050502@langendorff.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Niels Langendorff <linux@langendorff.nl>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 11, 2009 at 01:29:07PM +0100, Niels Langendorff wrote:

> for a samsung based project we have chosen two codecs, one for input, 
> the other for output. The two codecs are using the same I2S bus due to 
> audio requirements (HF audio in combination with EC)

> When having two machine implementations at the same time for the two 
> codecs we will run into problems attaching to the I2S bus. A solution is 
> to combine the machine implementation into one file, but then I probaly 
> have to modify generic kernel code.

> I there some solution for this and/or example code

This should work with the kernel as-is providing the two CODECs don't
both need register control, just declare DAI links for each of the links
you need from your machine driver.  Nothing will stop you adding one DAI
to multiple links.  You'll need to deal with resource contention issues
in your machine driver but it should have enough hooks already to
support that, or you can just arrange for your application to never try
to do anything unsupported.

If you run into problems doing this please bring them up on the list.
