From: Abramo Bagnara <abramo.bagnara@libero.it>
Subject: Re: [Fwd: ALSA OSS compatibility]
Date: Tue, 11 Feb 2003 17:23:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E492368.64D648A0@libero.it>
References: <3E48FBEC.76F19F85@libero.it> <s5hisvqolf9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Leif =?iso-8859-1?Q?=C5sbrink?= <leif.asbrink@mbox300.swipnet.se>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> At Tue, 11 Feb 2003 14:34:36 +0100,
> Abramo Bagnara wrote:
> >
> > Someone can confirm this is the OSS conformant behaviour?
> 
> yes.  but the behavior of ALSA oss-emulation described below is
> correct because it really supports that sample rate and channels
> through the software conversion as default.
> 
> this can be avoided by setting the "direct" mode per proc file (in the
> case of kernel oss emulation), as mentioned in
> alsa-kernel/Documentation/OSS-Emulation.txt.

Thank you, Takashi, I forgot that.

I'd like also to make Leif to note that the behaviour he's observing for
alsa-oss.c is likely due to the fact that he map dsp0 (or whatever) to a
pcm_plug ALSA device.

Mapping it to a pcm_hw device the alsa-oss behaviour should be exactly
what he want (i.e. alsa-oss choose the maximum speed available on
hardware).

-- 
Abramo Bagnara                       mailto:abramo.bagnara@libero.it

Opera Unica                          Phone: +39.546.656023
Via Emilia Interna, 140
48014 Castel Bolognese (RA) - Italy


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
