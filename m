From: Daniel Mack <daniel@caiaq.de>
Subject: Re: New Audio Driver Design
Date: Wed, 15 Jul 2009 22:22:08 +0200
Message-ID: <20090715202208.GA13236@buzzloop.caiaq.de>
References: <1b68c6790907132152pbfc1995k3be854627cb77f3e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9937224338
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jul 2009 22:22:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1b68c6790907132152pbfc1995k3be854627cb77f3e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 14, 2009 at 01:52:12PM +0900, jassi brar wrote:
>   I am to write an ALSA driver for my SOC which has a dedicated DSP
> subsystem which can
> be loaded with decoder instructions and parameteres, and then we load it
> with encoded data. The dsp then decodes the data and sends it to the PCM
> controller.

Are these decoder instruction something you need to do at runtime? Or
would it suffice to provide them once when the driver is probed?

For the first case, you could use the ALSA control interface, in
particular the SNDRV_CTL_ELEM_BYTES type.

For the latter, you might want to have a look at the firmware framework
and read Documentation/firmware_class/README.

Hope that helps,
Daniel
