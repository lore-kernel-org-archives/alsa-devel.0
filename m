From: Paul Davis <pbd@op.net>
Subject: Re: Re: hdsp on big-endian
Date: Wed, 22 May 2002 08:25:23 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205221223.g4MCNPj25743@post2.fast.net>
References: <s5hu1p0fmwr.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Wed, 22 May 2002 13:21:40 +0200."
             <s5hu1p0fmwr.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>anyway...  after looking at the hdsp code again, i found that these
>endian conversions are not necessary at all!
>IIRC, readX/writeX already convert the endianess in itself.  thus, the

absolutely not. readl/writel on most architectures translate to:

	   *addr = val;

>driver doesn't have to do anything in the access functions.
>(i'm not 100% sure about this - please correct me if it's wrong.) 

you're wrong, at least partly :)

the problem is that the HDSP's registers are all little endian. only
audio data is byteswapped by the hardware (if requested). so a BE
system that wants to write 0xfeedface to the HDSP needs to byteswap it
before writing it. Consider:

    LE: wants to write 0xfeedface, memory pattern: [fe][ed][fa][ce]
	      delivers 0xfeedface when using writel
    BE: wants to write 0xfeedface, memory pattern: [ce][fa][ed][fe]
	      thus must swap the bytes before writing them

>of course, if the data is stored in bytes as above, then the bytes
>must be swapped explicitly.  instead, we can use simply u32 arrays
>for the firmware data itself, so that the values can be passed without
>conversion.

right, and therein lies my confusion. Here's what I thought:

PPC (BE) system:
    
    data stored in char array
    not swapped when written to hardware

    => data in char array is laid out for a BE system.

I think I know see the mistake. The point is that the data is in a
char array and therefore is already correctly ordered for any-endian
system. the only thing that would go wrong is if you checked the 32
bit value of any part of the firmware on a BE system: you'd see the
wrong value. But its laid out in the char array the same way it is in
the HDSP memory, and thus it doesn't need swapping on any
architecture, just delivered as-is.

--p




_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
