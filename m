From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: difference between OSS mmap and alsa mmap?
 [alsa-oss]
Date: Tue, 24 Aug 2004 13:57:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040824135710.2422ef23@mango.fruits.de>
References: <20040705144251.6a286c94@mango.fruits.de>
	<200407051313.i65DDlH7023180@localhost.localdomain>
	<s5hvfh27fr6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvfh27fr6.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 05 Jul 2004 15:19:57 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 05 Jul 2004 09:13:46 -0400,
> Paul Davis wrote:
> > 
> > >the last thing i can see not working correctly in alsa-oss is the
> > >mmap emulati on [may closed source apps use OSS with mmap emu].
> > >jcdutton told me on irc tha t this is due to the differences in OSS
> > >mmaping and ALSA mmaping and it might not be possible to resolve
> > >these issues..
> > 
> > i don't think its possible. the OSS mmap API provides raw ptr access
> > to the DMA area of the h/w. you cannot intercede when an app just
> > uses pointer indirection and advance to read/write data. ALSA's API
> > does the same, of course, but access is bounded by two calls that
> > allow correct handling for devices where the DMA area is a bit more
> > complex than the OSS model allows for (e.g. 2 devices, or a device
> > that can't support mmap in hardware, or a dmix device, or ...)
> 
> A hack would be to call mmap_avail() in oss's GETSPACE (or similar)
> ioctls.  But, right, I don't think that the "perfect" emulation is
> possible on all hardwares as it is now, too.

btw: i might prove my ignorance with this question, but i have to ask:

what makes the kernel oss emu handle mmap so good? it's an emulation,
too, i suppose.. so what is the big difference in these two emulations,
that in one case it works well [kernel oss emu] and in the other it
seems almost impossible [libaoss.so]..

flo


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
