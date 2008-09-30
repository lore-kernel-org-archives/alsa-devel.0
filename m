From: Frank Mandarino <fmandarino@endrelia.com>
Subject: Re: [PATCH] ASoC: Remove references to Endrelia ETI-B1
 board
Date: Tue, 30 Sep 2008 11:30:01 -0400
Message-ID: <48E245F9.4050402@endrelia.com>
References: <48E23AE0.3040805@endrelia.com>
	<200809301611.01162.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ironport2-out.teksavvy.com (ironport2-out.pppoe.ca
	[206.248.154.182])
	by alsa0.perex.cz (Postfix) with ESMTP id 1045424535
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Sep 2008 17:30:02 +0200 (CEST)
In-Reply-To: <200809301611.01162.gineera@aspect135.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: ALSA devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


Alan Horstmann wrote:
> On Tuesday 30 September 2008 15:42, Frank Mandarino wrote:
>> See attached.
> 
> I am a bit unclear about the implications of this, when it was first discussed 
> and now there is a definite patch to remove eti_b1_wm8731.c
> 
> We based on this file to create an AT91<->wm8731 system; how is it proposed 
> that the codec is glued to the board in the future?  Or is most of the code 
> superfluous anyway?
> 
> Alan

The eti_b1_wm8731.c is the board-specific ASoC machine driver for our
proprietary ETI-B1 board.  It was only added to the kernel as an example
of an AT91 machine driver for others to use when developing a machine
driver for their own boards.

ASoC requires you to create your own machine driver to glue the codec to
the board.  The code is not superfluous.

If you have developed an AT91<->wm8731 board which you are planning to
sell, it makes sense to add your machine driver to the kernel so that
others can build a kernel for your board.  If you are not selling your
board, then it probably shouldn't be in the kernel and you should
maintain your machine driver privately.

This real issue is that only our company can test ASoC changes against
our board, and we don't have always have the resources to do this in a
timely fashion.  So I would rather not require others who make
improvements to ASoC to have to make changes to eti_b1_wm8731.c when
they are unable to test them.

Regards,
../fam
-- 
Frank Mandarino                                fmandarino(a)endrelia.com
Endrelia Technologies Inc.
Toronto, Ontario, Canada
