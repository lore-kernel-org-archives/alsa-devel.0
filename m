From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: WM8750 utilization
Date: Fri, 15 Aug 2008 17:58:15 +0100
Message-ID: <20080815165814.GI23120@sirena.org.uk>
References: <200808151832.37747.harryrat@postnuklear.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (unknown [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 432521038C9
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Aug 2008 18:58:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200808151832.37747.harryrat@postnuklear.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Harald Radke <harryrat@postnuklear.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Aug 15, 2008 at 06:32:37PM +0200, Harald Radke wrote:

> The Loox720 has a headphone jack, a earpiece and a speaker.

Please post your machine driver.  If you are doing code modifications to
make any of the changes you discuss below please also show these
changes.

> When driving LOUT1/ROUT1, sound goes via headphones, LOUT2/ROUT2 drives the 
> earpiece. When setting OUT3 on ROUT1, the speaker plays fine.

Could you please also clarify how the hardware is connected up here?
Which outputs on the device are connected to each of the headphone,
speaker and earpiece?

> - Trying to utilize headphone switch via the WM8750 registers doesn't really 
> work ): depending on the polarity bit either one of the OUTs is either not 
> muted at all or activated at all.

Are you sure that HPDETECT is wired up correctly and that the expected
level change occurs on it when the jack is inserted and removed?
