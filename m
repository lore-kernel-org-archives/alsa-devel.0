From: Thomas Fjellstrom <tfjellstrom@shaw.ca>
Subject: Re: rawmidi problem (was Re: ALSA homepage redesign)
Date: Mon, 22 Apr 2002 16:54:53 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0GUZ00D5PRIQZA@l-daemon>
References: <Pine.LNX.4.33.0204221307200.564-100000@pnote.perex-int.cz>
 <0GUZ0077CNVHZP@l-daemon> <20020423005521.B2708@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020423005521.B2708@sci.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On April 22, 2002 03:55 pm, you wrote:
> On Mon, Apr 22, 2002 at 03:35:08PM -0600, Thomas Fjellstrom wrote:
> > On April 22, 2002 03:27 pm, you wrote:
> > > On Mon, Apr 22, 2002 at 01:50:27PM -0600, Thomas Fjellstrom wrote:
> > > > I don't hear any sound when playing midi using the rawmidi interface
> > > > (using my SBLive! Value), I tried, some code written by me, and the
> > > > rawmidi.c source demo that is included with the driver package. (A
> > > > sound font is loaded, and midis play fine with sound, using the pmidi
> > > > program.)
> > >
> > > Are you using the right virmidi device?
> >
> > Ah. there had to be something I forgot to mention, I tried hw:0,1 hw:0,2
> > and hw:0,3 (with any number for subdevice which didn't give an error)
>
> I'm not sure how the emu10k1 driver maps the sequencer ports to virmidi
> devices but I'm pretty sure it does that automatically. Do the virmidi
> devices show up somewhere under /proc/asound? Also while playing do you
> see some activity in the files under /proc/asound/seq?

No activity. And no virmidi devices... lsmod shows that the virmidi module is 
loaded...

-- 
Thomas Fjellstrom
tfjellstrom@shaw.ca
http://strangesoft.net
