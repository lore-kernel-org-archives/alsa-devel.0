From: Thomas Fjellstrom <tfjellstrom@shaw.ca>
Subject: Re: rawmidi problem (was Re: ALSA homepage redesign)
Date: Tue, 23 Apr 2002 10:39:24 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0GV10038Z4T1KG@l-daemon>
References: <Pine.LNX.4.33.0204221307200.564-100000@pnote.perex-int.cz>
 <s5hadruoh65.wl@alsa2.suse.de> <s5h662iod14.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h662iod14.wl@alsa2.suse.de>
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

On April 23, 2002 05:44 am, you wrote:
> At Tue, 23 Apr 2002 12:14:42 +0200,
>
> I wrote:
> > At Mon, 22 Apr 2002 13:50:27 -0600,
> >
> > Thomas Fjellstrom wrote:
> > > I don't hear any sound when playing midi using the rawmidi interface
> > > (using my SBLive! Value), I tried, some code written by me, and the
> > > rawmidi.c source demo that is included with the driver package. (A
> > > sound font is loaded, and midis play fine with sound, using the pmidi
> > > program.)
> >
> > hmm it looks like a bug was introduced in virmidi or in a combination
> > of virmidi and rawmidi.  i think the rawmidi itself works fine.
> > this problem appears only on emu10k1's virmidi.
> >
> > i'll take a further look at this problem.
>
> now fixed on cvs.  actually it was a bug on virmidi.
>
> thanks for your notice.
>
>
> ciao,
>
> Takashi

Thanks alot! :)

-- 
Thomas Fjellstrom
tfjellstrom@shaw.ca
http://strangesoft.net
