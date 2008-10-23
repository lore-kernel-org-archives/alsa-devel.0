From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: Select source support in alsa soc
Date: Thu, 23 Oct 2008 11:29:46 +0100
Message-ID: <20081023102943.GB10280@sirena.org.uk>
References: <ef0d8a250810200024n1f1a4f90i41c7446241fdbb51@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E0D6E103824
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Oct 2008 12:30:04 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <ef0d8a250810200024n1f1a4f90i41c7446241fdbb51@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 20, 2008 at 12:54:00PM +0530, naveen krishna ch wrote:

> I have a driver now at a palce where i can play back with stereo headset and
> 
> record through line in cable.

> I need some understanding of how can i give support for selecting output and
> input sources.

> I have understood the way it is done in ALSA but i feel the sane should not
> be used in
> ALSA SOC frame work.

Normally this would be done through the standard ALSA APIs from user
space.  Depending on what exactly you wish to control in the hardware
this would either be done using the standard controls provided by the
codec driver or by defining additional controls for your machine in the
machine driver.  Several existing machine drivers such as the tosa
driver in sound/soc/pxa/tosa.c implement the second approach.

Often the software running on the device will have several standard
usage scenarios and change between them by restoring ALSA state files
with alsactl.  You may also find the scenario API here:

	http://opensource.wolfsonmicro.com/node/14

useful.
