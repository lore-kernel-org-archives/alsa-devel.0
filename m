From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [RFC 3/4] OMAP3: McBSP: Add interface for transmit
	FIFO state query
Date: Thu, 4 Mar 2010 10:09:49 +0200
Message-ID: <201003041009.49817.peter.ujfalusi@nokia.com>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<201003031202.48598.peter.ujfalusi@nokia.com>
	<1FFEF31EBAA4F64B80D33027D42977602148968E68@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id AA2EF103827
	for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2010 09:09:56 +0100 (CET)
In-Reply-To: <1FFEF31EBAA4F64B80D33027D42977602148968E68@NOK-EUMSG-02.mgdnok.nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello,

On Wednesday 03 March 2010 21:00:58 Nurkkala Eero.An (EXT-Offcode/Oulu) wro=
te:
> From: Ujfalusi Peter
> =

> > So according to XBUFSTAT we have played out 289 samples.
> > based on the time we actually played 288.528 samples.
> > =

> > I would say this is really close to what we would expect to have?
> > =

> > Note: I have used printk for these, which pretty much alters the behavi=
or
> > a bit in timing wise...
> > =

> > --
> > P=E9ter
> =

> There was something like this, reading XBUFFSTAT and RBUFFSTAT
> (adjacently), and comparing the diff, it should be 145 +-1 in this case,
> but that's not true:
> =

> (usespace app reading the values through a sysfs node):
> =

> 1: tx: 247, rx: 101, (tx-rx):  146, (480+(tx-rx))%480: 146
> 2: tx: 377, rx: 232, (tx-rx):  145, (480+(tx-rx))%480: 145
> 3: tx: 136, rx: 471, (tx-rx): -335, (480+(tx-rx))%480: 145
> 4: tx:  40, rx: 375, (tx-rx): -335, (480+(tx-rx))%480: 145
> 5: tx:  63, rx: 398, (tx-rx): -335, (480+(tx-rx))%480: 145
> 6: tx: 444, rx: 299, (tx-rx):  145, (480+(tx-rx))%480: 145
> 7: tx: 330, rx: 185, (tx-rx):  145, (480+(tx-rx))%480: 145
> 8: tx: 198, rx:  53, (tx-rx):  145, (480+(tx-rx))%480: 145
> 9: tx: 453, rx: 308, (tx-rx):  145, (480+(tx-rx))%480: 145
> 10: tx: 459, rx: 313, (tx-rx):  146, (480+(tx-rx))%480: 146
> 11: tx: 353, rx: 208, (tx-rx):  145, (480+(tx-rx))%480: 145
> 12: tx: 435, rx: 290, (tx-rx):  145, (480+(tx-rx))%480: 145
> 13: tx: 421, rx: 276, (tx-rx):  145, (480+(tx-rx))%480: 145
> 14: tx: 397, rx: 251, (tx-rx):  146, (480+(tx-rx))%480: 146
> 15: tx: 297, rx: 151, (tx-rx):  146, (480+(tx-rx))%480: 146
> 16: tx: 341, rx: 196, (tx-rx):  145, (480+(tx-rx))%480: 145
> 17: tx: 347, rx: 202, (tx-rx):  145, (480+(tx-rx))%480: 145
> 18: tx: 298, rx: 153, (tx-rx):  145, (480+(tx-rx))%480: 145
> 19: tx: 341, rx: 196, (tx-rx):  145, (480+(tx-rx))%480: 145
> 20: tx: 121, rx: 456, (tx-rx): -335, (480+(tx-rx))%480: 145
> 21: tx: 109, rx: 444, (tx-rx): -335, (480+(tx-rx))%480: 145
> 22: tx: 465, rx: 320, (tx-rx):  145, (480+(tx-rx))%480: 145
> 23: tx: 300, rx: 155, (tx-rx):  145, (480+(tx-rx))%480: 145
> 24: tx: 217, rx:  72, (tx-rx):  145, (480+(tx-rx))%480: 145
> 25: tx: 361, rx: 216, (tx-rx):  145, (480+(tx-rx))%480: 145
> 26: tx: 443, rx: 298, (tx-rx):  145, (480+(tx-rx))%480: 145
> 27: tx: 325, rx: 180, (tx-rx):  145, (480+(tx-rx))%480: 145
> 28: tx: 398, rx: 252, (tx-rx):  146, (480+(tx-rx))%480: 146
> 29: tx: 346, rx: 201, (tx-rx):  145, (480+(tx-rx))%480: 145
> 30: tx: 474, rx: 329, (tx-rx):  145, (480+(tx-rx))%480: 145
> 31: tx: 323, rx: 178, (tx-rx):  145, (480+(tx-rx))%480: 145
> 32: tx: 349, rx: 204, (tx-rx):  145, (480+(tx-rx))%480: 145
> 33: tx: 202, rx:  57, (tx-rx):  145, (480+(tx-rx))%480: 145
> 34: tx: 462, rx: 317, (tx-rx):  145, (480+(tx-rx))%480: 145
> 35: tx:  87, rx: 422, (tx-rx): -335, (480+(tx-rx))%480: 145
> 36: tx: 407, rx: 262, (tx-rx):  145, (480+(tx-rx))%480: 145
> 37: tx: 354, rx: 209, (tx-rx):  145, (480+(tx-rx))%480: 145
> 38: tx: 377, rx: 232, (tx-rx):  145, (480+(tx-rx))%480: 145
> 39: tx: 435, rx: 290, (tx-rx):  145, (480+(tx-rx))%480: 145
> 40: tx: 456, rx: 311, (tx-rx):  145, (480+(tx-rx))%480: 145
> 41: tx: 466, rx: 321, (tx-rx):  145, (480+(tx-rx))%480: 145
> 42: tx: 349, rx: 204, (tx-rx):  145, (480+(tx-rx))%480: 145
> 43: tx: 328, rx: 183, (tx-rx):  145, (480+(tx-rx))%480: 145
> 44: tx: 385, rx: 240, (tx-rx):  145, (480+(tx-rx))%480: 145
> 45: tx: 115, rx: 450, (tx-rx): -335, (480+(tx-rx))%480: 145
> 46: tx: 297, rx: 152, (tx-rx):  145, (480+(tx-rx))%480: 145
> 47: tx: 332, rx: 187, (tx-rx):  145, (480+(tx-rx))%480: 145
> 48: tx: 298, rx: 153, (tx-rx):  145, (480+(tx-rx))%480: 145
> 49: tx: 432, rx: 286, (tx-rx):  146, (480+(tx-rx))%480: 146
> 50: tx:  99, rx: 434, (tx-rx): -335, (480+(tx-rx))%480: 145
> 51: tx:  96, rx: 431, (tx-rx): -335, (480+(tx-rx))%480: 145
> 52: tx: 380, rx: 235, (tx-rx):  145, (480+(tx-rx))%480: 145
> 53: tx: 417, rx: 272, (tx-rx):  145, (480+(tx-rx))%480: 145
> 54: tx: 272, rx: 337, (tx-rx):  -65, (480+(tx-rx))%480: 415 < NOK
> 55: tx: 391, rx: 246, (tx-rx):  145, (480+(tx-rx))%480: 145
> 56: tx: 305, rx: 336, (tx-rx):  -31, (480+(tx-rx))%480: 449 < NOK
> =

> what went wrong? (the pcm pointer w/dma pos never missed that
> greatly)

I see your point.

> Very unlikely that an IRQ just happened to come in between the
> register reads..with that frequency (> 1/50)

I don't think that this has anything to do with IRQ, it looks to me more li=
ke an =

'accident' in the timing of the reading the buffstat registers.

> so subjectively XBUFFSTAT / RBUFFSTAT are not useful for
> any "real" use...

Well, yes and no. we can get good estimation with this I think still.

> =

> - Eero

How I see this:
In your code, you have a sysfs file, which can be read from user space.
User space semi randomly reading that file to get the buffstat values.
These registers are reflecting the buffer state on the L4 clock domain, whi=
ch =

means that the actual value might differ.
So I think what happens is, that the user space happens to read the buffsta=
t =

registers most of the time, when neither the TX or RX is buffer has burst D=
MA =

access, but time to time you can hit a point 'by accident' or just because =
of =

the state of the moon, when either of the TX or/and RX is actually under DM=
A =

burst. Since this burst is fast, L4 domain register can not be updated as =

frequently, so it will reflect a bit later state of the buffer. If this hap=
pens =

you will have inconsistent relation between TX and RX.

But I think, if you have similar sysfs file for comparing the DMA pointers =
you =

will also hit the same spot.
If you happened to read the pointers when one of the stream is in DMA burst=
, =

than you will definitely have the same problem.  =

So the DMA pointer comparison is 'correct' when neither of the stream are i=
n DMA =

burst.
Same goes for the buffstat registers: if neither of the streams are in burs=
t =

they will provide pretty good numbers.

Since the pointer callback is naturally called after a period has been sent=
, the =

DMA is not in burst anymore, so the reading of buffstat on the given stream=
 will =

give close enough estimation on the delay caused by the FIFO.

But yes, as you mentioned in your mail, this estimation can be done using =

timestamp in DMA completion handler, and than calculate the delay based on =
the =

timestamp we got, the threshold, and the size of the FIFO on the given McBS=
P =

port.


-- =

P=E9ter
