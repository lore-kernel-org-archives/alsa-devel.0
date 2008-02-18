From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Random inverted audio channels
Date: Mon, 18 Feb 2008 09:54:42 +0000
Message-ID: <20080218095442.GB21314@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 35EAB244E9
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 10:54:44 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alexandre BOUIN <a.bouin@kerlink.fr>
Cc: alsa-devel@alsa-project.org, 'Frank Mandarino' <fmandarino@endrelia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Feb 18, 2008 at 09:38:12AM +0100, Alexandre BOUIN wrote:

> We are porting a WM8900 driver from a 8731 one. It fit quite well our
> requirements and should not be the same as your dev branch.
> Sincerely, It didn't know you're working on it.

No problem at all - I was just asking from curiosity.

> > The most likely issue here is a DMA underrun but from what you say you
> > may already have ruled that out?  It would be helpful if you could run
> > through the debugging you've already done here.

> I had traced the addresses sent into PDC (soc/at91-pcm.c), and are always
> the same.
> What other traces are you looking for ?

Have you checked to make sure that the PDC is not reporting any errors?
