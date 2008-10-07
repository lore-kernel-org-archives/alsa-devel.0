From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC WM8510 Mic PGA problem
Date: Tue, 7 Oct 2008 14:43:20 +0100
Message-ID: <20081007134318.GF19835@sirena.org.uk>
References: <B9D3C48C98930741A166756A50C44A610F17B555@helx1.corp.vaisala.com>
	<20081003133936.GD26035@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B556@helx1.corp.vaisala.com>
	<20081006100522.GB14087@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B55A@helx1.corp.vaisala.com>
	<20081007121144.GA5119@rakim.wolfsonmicro.main>
	<B9D3C48C98930741A166756A50C44A610F17B55D@helx1.corp.vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1E0AF245B7
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Oct 2008 15:43:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B9D3C48C98930741A166756A50C44A610F17B55D@helx1.corp.vaisala.com>
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

On Tue, Oct 07, 2008 at 04:29:43PM +0300, ext-jukka.hynninen@vaisala.com wrote:

> Anyway, I noticed an interesting point (applying the patch had no effect
> on this):
> The first recording on a freshly booted system seems to complete without
> changing the status of Mic PGA control.

Could you please rebuild ASoC with debug enabled and send the kernel
output produced from a failing record?  Depending on your kernel version
you'll either see some relevant defines at the top of soc-core.c and
soc-dapm.c or you should #define DEBUG at the top of those files.

Putting some trace in wm8510_reg_write() logging all the codec writes
while doing this would also be interesting.
