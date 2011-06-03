From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc atmel_ssc: Don't try to free ssc if
	request failed
Date: Fri, 3 Jun 2011 10:08:18 +0100
Message-ID: <20110603090817.GD21286@opensource.wolfsonmicro.com>
References: <BANLkTin=o135Ayy_yKiJ3JUs91Y_k9ciVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0466510391B
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 11:08:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTin=o135Ayy_yKiJ3JUs91Y_k9ciVw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: sedji.gaouaou@atmel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 01, 2011 at 11:59:10PM +0200, Joachim Eastwood wrote:
> Hello,
> 
> Patch below fixes a segmentation fault in atmel_ssc_dai if ssc_request() fails.
> 
> We should only call ssc_free() when ssc_request() succeeds or bad
> things will happen.
> 
> Signed-off-by: Joachim Eastwood <joachim.eastwood@jotron.com>

Applied, thanks.  Please try to follow the patch format in
SubmittingPatches - in particular, remember that the body of your mail
is going to get used as the commit message.
