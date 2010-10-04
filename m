From: Daniel Mack <daniel@caiaq.de>
Subject: Re: S51 usb support
Date: Mon, 4 Oct 2010 06:41:52 +0200
Message-ID: <20101004044152.GC7159@buzzloop.caiaq.de>
References: <4CA8F3F8.6010705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 398FB103871
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Oct 2010 06:42:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4CA8F3F8.6010705@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matti Picus <matti.picus@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Oct 03, 2010 at 11:22:00PM +0200, Matti Picus wrote:
> My X-FI Surround USB card is barely usable. pulseaudio will let me 
> control the volume levels, alsa support cannot view any volume controls.

But audio streaming does work for you? I heard people reporting success
with this kind of hardware.

> How can I contribute to better support for this card under alsa? I would 
> like to get to the point where amixer can control the analog 
> input/output volume levels.

As for the volume controls, there are merely two ways how they can be
implemented on USB soundcards. One is as feature unit control, and the
other is a proprietary vendor specific USB request. You should start
having a look at the USB descriptors the devices exports (by running
"lsusb -v").

In case the card does not offer a standard way to control the volume
levels, you need to trace how the Windows driver does it by sniffing
the communication while performing this specific operation, either with
an USB hardware analyzer, or with a piece of software. There are some
projects aiming for this, but I can't give you any recommendation. Just
try some of these, maybe:

  http://www.google.com/search?q=windows+usb+traffic+sniffer

Once you found out how they do it in Windows, you can add device
specific mixer handlers, as they exist for other hardware. Have a look
at sound/usb/mixer_quirks.c.

Hope that helps,

Daniel
