From: Frank van de Pol <fvdpol@home.nl>
Subject: Re: more sample formats?  too little place left.
Date: Mon, 3 Jun 2002 22:06:28 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020603200637.GA18082@idefix.fvdpol.home.nl>
References: <s5h3cw8gzvo.wl@alsa2.suse.de> <007e01c208d2$31938120$0400a8c0@martijn> <s5hlm9wfper.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hlm9wfper.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Martijn Sipkema <msipkema@sipkema-digital.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Using the mask is only usefull for inquiry of supported formats; if it was
for specifying a format a simple numeric value would be fine. 

Would extending the bitfield to 64 bits solve the problem for now and
forever? I suppose it would give us some air, but on the other hand, more
formats exist in the world, with each different packing and notiation. 

eg. 18 and 20 bits packed in 24 bits or 32 bits stream; floating point
formats in various flavours like 32 bit 24.0, 32 bit 16.8, 32 bit 0.24 etc.
- ok, last one is supported as SND_PCM_FORMAT_FLOAT_LE/BE). Not to mention
future things like the GSM/MPEG/ADPCM encodings etc. 

just thinking out loud... 

Frank.

On Mon, Jun 03, 2002 at 03:43:56PM +0200, Takashi Iwai wrote:
> At Fri, 31 May 2002 19:36:54 +0100,
> Martijn Sipkema wrote:
> > 
> > > it seems that USB audio supports 24 bit sample in 3 bytes format.
> > > and additionally i've found there are 20bit and 18bit sample formats.
> > > the world is large...
> > > 
> > > an arising problem is that the number of formats is limited to 32.
> > > already 26 format types are used.  the rest are only 6, and not enough
> > > if we put BE/LE and signed/unsigned for new formats, too.
> > > 
> > > how can we solve this?  extend to 64bit?  no, it has too overhead.
> > > add a new field for special formats?
> > > 
> > > perhaps we don't need all of them for such special formats.
> > > there are no unsigned types for such formats.
> > > but anyway the left resource is too small.
> > 
> > are formats currently a bit in a 'supported formats' flag?
> 
> yes.
> 
> the problem is that the bitmask is defined as unsigned int, und
> limitied to 31 bits.
> 

-- 
+---- --- -- -  -   -    - 
| Frank van de Pol                  -o)    A-L-S-A
| FvdPol@home.nl                    /\\  Sounds good!
| http://www.alsa-project.org      _\_v
| Linux - Why use Windows if we have doors available?

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
