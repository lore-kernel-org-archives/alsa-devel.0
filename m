From: Daniel Mack <daniel@caiaq.de>
Subject: Re: usb- interface - HID type
Date: Mon, 30 Nov 2009 09:19:20 +0100
Message-ID: <20091130081920.GX29442@buzzloop.caiaq.de>
References: <1257435101.25623.1.camel@localhost>
	<1257720370-23012-1-git-send-email-GNUtoo@no-log.org>
	<20091113145050.GC30966@sirena.org.uk>
	<1259536602.3374.129.camel@gnutoo-desktop>
	<1259538217.24419.1.camel@gnutoo-desktop>
	<4B135345.1030906@india.nsc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 9EDB8103825
	for <alsa-devel@alsa-project.org>; Mon, 30 Nov 2009 09:19:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4B135345.1030906@india.nsc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: M R Swami Reddy <swami@india.nsc.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Nov 30, 2009 at 10:38:21AM +0530, M R Swami Reddy wrote:
> I have a sound card with I2C/PCM interface supported. I am in the 
> process of evaluate
> the same using USB interface with HID interface class (ie 
> bInterfaceClass ->3 Human Interface Device).
> Could you please suggest, if the usb interface HID class could be used 
> for sending Audio and PCM
> signals?

As of the USB logic, the ALSA driver should grab the audio interface
while at the same time, the HID driver uses the other interface.
Assuming that both interfaces are in the same USB config.

HTH,
Daniel
