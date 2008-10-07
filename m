From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC WM8510 Mic PGA problem
Date: Tue, 7 Oct 2008 15:27:02 +0100
Message-ID: <20081007142701.GG19835@sirena.org.uk>
References: <B9D3C48C98930741A166756A50C44A610F17B555@helx1.corp.vaisala.com>
	<20081003133936.GD26035@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B556@helx1.corp.vaisala.com>
	<20081006100522.GB14087@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B55A@helx1.corp.vaisala.com>
	<20081007121144.GA5119@rakim.wolfsonmicro.main>
	<B9D3C48C98930741A166756A50C44A610F17B55D@helx1.corp.vaisala.com>
	<20081007134318.GF19835@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B55E@helx1.corp.vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A2EA245E0
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 16:27:15 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B9D3C48C98930741A166756A50C44A610F17B55E@helx1.corp.vaisala.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext-jukka.hynninen@vaisala.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 07, 2008 at 05:21:48PM +0300, ext-jukka.hynninen@vaisala.com wrote:
> Quoting Mark Brown:

> > Could you please rebuild ASoC with debug enabled and send the kernel
> > output produced from a failing record?  Depending on your kernel
> version

> I'm sorry, It seems to be the switch connecting MICN to negative PGA
> terminal that does not stay on (register 0x2c bit 1)

So the ALSA control 'Mic PGA MICN Switch'?
