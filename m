From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: What does 0dB refer to? (Logitech USB Speakers)
Date: Sun, 13 Apr 2008 18:48:34 +0100
Message-ID: <20080413174833.GA31398@sirena.org.uk>
References: <20080411204610.GA32413@tango.0pointer.de>
	<480099C6.3040708@superbug.co.uk>
	<20080412133536.GC32491@tango.0pointer.de>
	<48010E62.2020404@keyaccess.nl> <4801269B.6090101@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 42D3324817
	for <alsa-devel@alsa-project.org>;
	Sun, 13 Apr 2008 19:48:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4801269B.6090101@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 12, 2008 at 11:16:11PM +0200, Rene Herman wrote:

> Mmm, no, this control seems to be divided into two parts in hardware, with 
> -60 dB to 0 digital attenuation pre DAC and -34.5 to +12 dB analog post DAC. 
> Odd, but anyways... 0 is still the "correct" default.

That's pretty much standard for codec chips, especially those with
multiple output paths or multiple data sources that can be fed into a
given output.
