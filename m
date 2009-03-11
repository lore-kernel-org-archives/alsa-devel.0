From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Problem compiling soc - imx31 and wm8753
Date: Wed, 11 Mar 2009 21:53:41 +0000
Message-ID: <20090311215340.GA6483@sirena.org.uk>
References: <49B7CEFD.1080006@tecnequip.com.br>
	<20090311153554.GB15629@sirena.org.uk>
	<49B7F01C.2070202@tecnequip.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 452161038A2
	for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2009 22:53:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49B7F01C.2070202@tecnequip.com.br>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marcelo Utikawa da Fonseca <marcelo.fonseca@tecnequip.com.br>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 11, 2009 at 02:08:44PM -0300, Marcelo Utikawa da Fonseca wrote:

> The i.MX31 Freescale's BSP does not have asoc support, just an interface  
> for MC13783 (a Power Management IC from Freescale with integrated audio  
> interface).
> The wolfsonmicro's tree is the only one that have support to asoc but it  
> does not compiles using the mentioned steps.
> Am I missing something or may be these drivers broken?

As I say, the drivers rely on code in the Freescale BSP; you may not
have the lastest Freescale BSP.  There is some code here:

	git://opensource.wolfsonmicro.com/linux-2.6-audioplus imx31

but note that this uses ASoC v2 so will definitely require some porting
of the WM8731 driver unless the copy there is already up to date.  That
tree is entirely focused on supporting the WM835x (an audio+PMIC device
comprable to the Atlas which is shipped by default) with the i.MX31ADS.
