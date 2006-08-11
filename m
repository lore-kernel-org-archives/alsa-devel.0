From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Line6 TonePort
Date: Fri, 11 Aug 2006 19:21:53 +0200
Message-ID: <1155316913.11766.268179999@webmail.messagingengine.com>
References: <160c13350608100919yee3fc8p14096f59aa0071f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <160c13350608100919yee3fc8p14096f59aa0071f7@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Stefano D'Angelo <zanga.mail@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Stefano D'Angelo wrote:
> The problem is quite simple: this USB card does not support DMA transfers

No USB device supports DMA transfers.  USB devices support USB transfers.

The host controller supports DMA transfers.  Yours does, too.

> Takashi told me to use an intermediate buffer,

This is just because the buffer for a USB frame must be continguous, but
you cannot always guarantee this when you're near the end of ALSA's ring
buffer.

> but I really don't know how to do it.  Should I copy data from the
> buffer (playback) on usb transfer completition callbacks?

You should copy the data just before you submit the URB.  In other words,
yes.

> But in such case isn't it the same to just copy data into the urb's
> transfer buffer?

This is indeed the same.  The URB's transfer buffer _is_ the
intermediate buffer mentioned by Takashi.

The opposite, i.e., not using an intermediate buffer, would mean that
the URB's transfer_buffer pointed into ALSA's ring buffer.

> I tried to avoid using this buffer and what I obtain is something that
> resembles what the card should be playing but with huge noise.

How do you determine how much data to send in each USB frame?


Regards,
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
