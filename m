From: Hannu Savolainen <hannu@opensound.com>
Subject: Re: Re: [OT] ALSA userspace API complexity
Date: Tue, 10 Jan 2006 04:17:03 +0200 (EET)
Message-ID: <Pine.LNX.4.61.0601100408480.18971__42646.9223261394$1136859670$gmane$org@zeus.compusonic.fi>
References: <20050726150837.GT3160@stusta.de> <200601091405.23939.rene@exactcode.de>
 <Pine.LNX.4.61.0601091637570.21552@zeus.compusonic.fi> <200601091812.55943.rene@exactcode.de>
 <Pine.LNX.4.62.0601091355541.4005@qynat.qvtvafvgr.pbz>
 <20060109232043.GA5013@localhost.localdomain> <Pine.LNX.4.61.0601100212290.26233@zeus.compusonic.fi>
 <20060110020017.GB5375@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from minor.compusonic.fi (host1.compusonic.fi [195.238.198.242])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1716613D
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2006 03:19:40 +0100 (MET)
In-Reply-To: <20060110020017.GB5375@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: John Rigg <ad@sound-man.co.uk>
Cc: David Lang <dlang@digitalinsight.com>, =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>, Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org, ALSA development <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 10 Jan 2006, John Rigg wrote:

> On Tue, Jan 10, 2006 at 02:48:35AM +0200, Hannu Savolainen wrote:
> > On Mon, 9 Jan 2006, John Rigg wrote:
> > 
> > > Yes, but the CPU has plenty of other work to do. The sound cards that
> > > would be worst affected by this are the big RME cards (non-interleaved) and
> > > multiple ice1712 cards (non-interleaved blocks of interleaved data),
> > ice1712 uses normal interleaving. There are no "non-interleaved blocks".
> 
> With two ice1712 cards I had to patch jackd for MMAP_COMPLEX
> support to make them work together. My understanding was that the
> individual cards use interleaved data, but when several are combined
> the resulting blocks of data are not interleaved together. I realise the
> usual way of dealing with this is to use the alsa route plugin with
> ttable to interleave them, but I couldn't get it to work with these
> cards.
Right. If you use two cards then both of them have independently 
interleaved blocks. However if this kind of mapping belongs to the lowest 
level audio API or not is yet another API feature to argue about.  Higher 
level libraries like Jack could do this themselves.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
