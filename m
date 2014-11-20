From: Jurgen Kramer <gtmkramer@xs4all.nl>
Subject: Re: [PATCH] pcm: add new 32-bit DSD sample format
Date: Thu, 20 Nov 2014 17:34:48 +0100
Message-ID: <1416501288.2996.1.camel@xs4all.nl>
References: <1410332428-16571-1-git-send-email-gtmkramer@xs4all.nl>
 <546CF486.7010009@sonarnerd.net> <s5hy4r6xkfu.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb1-smtp-cloud3.xs4all.net (lb1-smtp-cloud3.xs4all.net
 [194.109.24.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 844F62605BF
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 17:34:50 +0100 (CET)
In-Reply-To: <s5hy4r6xkfu.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jussi Laako <jussi@sonarnerd.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2014-11-20 at 10:58 +0100, Takashi Iwai wrote:
> At Wed, 19 Nov 2014 21:50:30 +0200,
> Jussi Laako wrote:
> > 
> > Hi,
> > 
> > Sorry for catching up late on this patch...
> > 
> > On 10.09.2014 10:00, Jurgen Kramer wrote:
> > > +	FORMATD(DSD_U32_LE, "Direct Stream Digital, 4-byte (x32), little endian, oldest bits in MSB"),
> > 
> > There is bug in this patch. The spec for these formats is, as above says 
> > "little endian, oldest bits in MSB", however with the iFi iDSD Nano this 
> > doesn't seem to be the case. Oldest bits are in MSB of the byte, but 
> > byte order is big endian.
> 
> Is it a bug of spec, or a bug of device?
> In the latter case, we'd need to introduce DSD_U32_BE format and apply
> a quirk, for example.
DSD is a bit odd wrt LE/BE. Both formats are allowed and used.
The device (XMOS based/Marantz+Denon) want the following order of
samples: 
L1 L2 L3 L4 R1 R2 R3 R4. Where Lx/Rx are 8-bit DSD samples, L1-L4 are
packed to 1 32-bit sample.

I do think real BE will not work.

Jurgen
> 
> Takashi
> 
> > IOW, following alone will produce incorrect 
> > output:
> > 
> > size_t N = 32;
> > uint32_t x = 0;
> > while (N--)
> > {
> > 	x <<= 1;
> > 	x |= nextbit;
> > }
> > 
> > But if you add __builtin_byteswap32(x) then the output is correct.
> > 
> > I guess this has not been caught because of just memcpy()'ing the 
> > oldest-bit-in-MSB byte stream to the sample buffer instead of 
> > constructing the words...
> > 
> > 
> > Best regards,
> > 
> > 	- Jussi
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
