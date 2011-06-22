From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How to implement capture_switch control?
Date: Wed, 22 Jun 2011 14:06:44 +0100
Message-ID: <20110622130644.GG23666@sirena.org.uk>
References: <BANLkTikZYqdQJh6T1_XwpcxcTb=m1qOuUw@mail.gmail.com>
	<20110621015149.GA3753@sirena.org.uk>
	<BANLkTinwT4TLrmaVOmLUfQE+zPAzH=zZ2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CC8D31039F7
	for <Alsa-devel@alsa-project.org>;
	Wed, 22 Jun 2011 15:06:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTinwT4TLrmaVOmLUfQE+zPAzH=zZ2A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Jiang <jiang.adam@gmail.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 22, 2011 at 04:56:26PM +0900, Adam Jiang wrote:
> 2011/6/21 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> > On Mon, Jun 20, 2011 at 04:15:38PM +0900, Adam Jiang wrote:

> > If the hardware does not physically support mute then this should be
> > emulated in software. ?In the case of the WM8903 the device does not
> > have a specific capture mute control, though extremely low gains are
> > supported for the Capture Volume control which function as a mute so
> > you could also set minimum Capture Volume.

> I got the idea about software emulation for mute. Would you please
> point me to an example about device/driver where hardware capture
> switch is supported?

grep "Capture Switch" sound/soc/codecs/*.c
