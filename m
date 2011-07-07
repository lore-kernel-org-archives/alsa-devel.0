From: Daniel Mack <zonque@gmail.com>
Subject: Re: Allocating buffers for USB transfers (again)
Date: Thu, 7 Jul 2011 14:38:51 +0200
Message-ID: <CACTFLAN=GOw8KLtvVBM6omvYzW3RBHggv-Kc2_2QVD--M-Jxkg@mail.gmail.com>
References: <CACTFLANCYMXH=z+NxEF0aqpMGZp21Q16_uB=J3rndM3pW74qeA@mail.gmail.com>
	<201107071433.42081.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201107071433.42081.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-usb@vger.kernel.org, alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, florian@mickler.org, pedrib@gmail.com, William Light <wrl@illest.net>, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jul 7, 2011 at 2:33 PM, Oliver Neukum <oliver@neukum.org> wrote=
:

> PS: =A0Do you still see this if you enable 64bit DMA for EHCI?

The problem is that I personally don't see that issue at all. I even
installed 4GB of RAM to my development machine last year to be able to
reproduce this, but I can't, even when the memory allocator is under
heavy load. The only people who see this effect are Pedro Ribeiro and
William Light (both in Cc:), and both have been very helpful in trying
patches and reporting back in detail. Which instructions could we
probably give to these people to finally hunt this issue down?

Daniel
