From: Trent Piepho <xyzzy@speakeasy.org>
Subject: Re: [PATCH] Improved support for different bt87x board
 configurations
Date: Sun, 2 Sep 2007 16:21:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0709021603380.18152@shell4.speakeasy.net>
References: <Pine.LNX.4.58.0708300319210.18152@shell4.speakeasy.net>
	<s5h3ay1i8rs.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail8.sea5.speakeasy.net (mail8.sea5.speakeasy.net
	[69.17.117.10]) by alsa0.perex.cz (Postfix) with ESMTP id 8F6B7243B2
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 01:21:59 +0200 (CEST)
In-Reply-To: <s5h3ay1i8rs.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 30 Aug 2007, Takashi Iwai wrote:
> One thin I don't like so much is:
>
> > +#define BT_DEVICE(chip, subvend, subdev, id) \
> >  	{ .vendor = PCI_VENDOR_ID_BROOKTREE, \
> > -	  .device = chip, \
> > +	  .device = PCI_DEVICE_ID_BROOKTREE ## chip, \
> >  	  .subvendor = subvend, .subdevice = subdev, \
> > -	  .driver_data = rate }
> > -
> > -/* driver_data is the default digital_rate value for that device */
> > +	  .driver_data = id }
> > +/* driver_data is the card id for that device */
> > +
> >  static struct pci_device_id snd_bt87x_ids[] = {
> >  	/* Hauppauge WinTV series */
> > -	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, 0x0070, 0x13eb, 32000),
> > +	BT_DEVICE(_878, 0x0070, 0x13eb, SND_BT87X_BOARD_HAUPPAUGE878),
> >  	/* Hauppauge WinTV series */
>
> The word _878 looks strange.  PCI_DEVICE_ID_BROOKTREE_878 is more
> obvious that it's a macro and the readability isn't so bad.
> I'd say, let it be.

The only problem is that PCI_DEVICE_ID_BROOKTREE_878 is so long that the
lines become longer than 80 columns.  They have to be wrapped, so it's no
longer one line, one card and less readable.  It's also easier to miss that
one line says PCI_DEVICE_ID_BROOKTREE_879, when you have such a long string
repeated many times, with only one digit different.

What if I used "BROOKTREE_878" or some suffix of that?
