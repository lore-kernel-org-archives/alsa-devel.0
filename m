From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How to use soc API without codec driver
Date: Tue, 8 Dec 2009 14:51:04 +0000
Message-ID: <20091208145104.GC9018@sirena.org.uk>
References: <4B1E66DD.1000906@heig-vd.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A48A10384E
	for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2009 15:51:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B1E66DD.1000906@heig-vd.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Marc Garnier <marc.garnier@heig-vd.ch>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 08, 2009 at 03:46:53PM +0100, Marc Garnier wrote:

> I need to receive and transmit PCM data through SSC port of a sam9261 to 
> a device which doesn't have any kind of I/O controls (neither i2c nor 
> spi). So, I wonder how to deal with the codec driver side.
> Someone could explain me what are the minimum requirements to write a 
> Asoc driver of this kind?

There's a couple of drivers for such CODECs in the tree already - have a
look at the wm8727 driver for one example.  You need to register at
least a DAI with whatever the capabilities of the hardware are and can
leave all the operations blank.
