From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Support for the Bluetooth subband codec (SBC)
Date: Mon, 08 Nov 2004 13:09:07 +0100
Message-ID: <1099915747.6896.113.camel@pegasus>
References: <1099878354.6896.80.camel@pegasus>
	 <Pine.LNX.4.58.0411081155020.2162@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0411081155020.2162@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

> > besides the Bluetooth headset/handsfree support there is another type of
> > audio support. It is the high quality audio (A2DP) for headphones and so
> > on. To include a native support for these devices with every Bluetooth
> > adapter (for example the ones built into your notebook) it is necessary
> > to support the subband codec (SBC) from Philips. The codec description
> > is in the Advanced Audio Distribution Profile (A2DP).
> > 
> > I am not an audio expert and far away from doing any codec specific
> > things, but from my understanding the ALSA kernel part should be
> > extended with the SBC type for PCM devices and the library should know
> > how to convert any PCM data into the SBC format so we can use it inside
> > the kernel in a A2DP driver.
> 
> Any datasheet for this format? Anyway, if SBC format only encapsulates 
> linear PCM samples to packets, then it should be handled in the driver 
> like the USB driver does.

the datasheet for this codec can be found on the Bluetooth specification
webpage (www.bluetooth.org/spec/). It is part of the A2DP document. I
think you need to be logged in to get it and so I will send it to you in
a private mail later.

I don't think that this is linear PCM, but actually I am no expert when
it comes to codec specific stuff. I would be great if you can take a
look at it and tell me what you think how we should support it.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
