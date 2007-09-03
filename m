From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [PATCH] Improved support for different bt87x board
 configurations
Date: Mon, 03 Sep 2007 08:36:47 +0200
Message-ID: <1188801407.6762.1208578117@webmail.messagingengine.com>
References: <Pine.LNX.4.58.0708300319210.18152@shell4.speakeasy.net>
	<s5h3ay1i8rs.wl%tiwai@suse.de>
	<Pine.LNX.4.58.0709021603380.18152@shell4.speakeasy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id BCDF0103867
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 08:36:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0709021603380.18152@shell4.speakeasy.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Trent Piepho <xyzzy@speakeasy.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Trent Piepho wrote:
> On Thu, 30 Aug 2007, Takashi Iwai wrote:
> > > -	BT_DEVICE(PCI_DEVICE_ID_BROOKTREE_878, 0x0070, 0x13eb, 32000),
> > > +	BT_DEVICE(_878, 0x0070, 0x13eb, SND_BT87X_BOARD_HAUPPAUGE878),
> > >  	/* Hauppauge WinTV series */
> >
> > The word _878 looks strange.  PCI_DEVICE_ID_BROOKTREE_878 is more
> > obvious that it's a macro and the readability isn't so bad.
> > I'd say, let it be.
> 
> The only problem is that PCI_DEVICE_ID_BROOKTREE_878 is so long that the
> lines become longer than 80 columns.  They have to be wrapped, so it's no
> longer one line, one card and less readable.  It's also easier to miss that
> one line says PCI_DEVICE_ID_BROOKTREE_879, when you have such a long string
> repeated many times, with only one digit different.
> 
> What if I used "BROOKTREE_878" or some suffix of that?

My earlier version of the driver that did use "BT_DEVICE(878, ...)" was
changed to use PCI_DEVICE_ID_BROOKTREE_878 because only the complete
symbol allows to search for PCI IDs with grep.

You could drop the SND_BT87X_ prefix from the board symbols.

The 80 column limit isn't that hard when exceeding it really improves
readability.


Regards,
Clemens
