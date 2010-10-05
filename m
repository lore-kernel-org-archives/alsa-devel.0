From: Daniel Mack <daniel@caiaq.de>
Subject: Re: S51 usb support
Date: Tue, 5 Oct 2010 09:38:54 +0200
Message-ID: <20101005073853.GL7159@buzzloop.caiaq.de>
References: <4CA8F3F8.6010705@gmail.com>
	<20101004044152.GC7159@buzzloop.caiaq.de>
	<4CAA3458.9080007@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id EC396103917
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Oct 2010 09:38:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4CAA3458.9080007@gmail.com>
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

On Mon, Oct 04, 2010 at 10:08:56PM +0200, Matti Picus wrote:
> On 10/04/2010 06:41 AM, Daniel Mack wrote:
> >As for the volume controls, there are merely two ways how they can be
> >implemented on USB soundcards. One is as feature unit control, and the
> >other is a proprietary vendor specific USB request. You should start
> >having a look at the USB descriptors the devices exports (by running
> >"lsusb -v").
> >
> OK, what should I be looking for? Here is a summary:

Normally, the volume would be controlled by a feature unit. Just post
the whole output of 'lsusb -v' to some pastebin website and post the
link.

> The card must offer something close to a standard set of volume
> controls since pulseaudio can control the basic stereo volume
> sliders. 

No. PulseAudio will do the volume control in software if there are no
hardware controls.

> I would be happy if amixer or even alsamixer would see just
> the analog stereo output and analog line-in input. Currently,
> pulseaudio can control the volume levels but alsa cannot, alsamixer
> simply shows no volume controls.

Yes, because the driver doesn't know about any volume controls. If you
manage to implement them, PA will also use them.

> Any guidance you can give toward getting the volume controls
> recognized would be greatly appreciate.

The best way is to sniff the USB communication when Windows sets the
volume, and add controls to the Linux driver and make it do the same
thing.


Daniel
