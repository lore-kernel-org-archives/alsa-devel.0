From: Mark Hubbard <mark@egghead.free-online.co.uk>
Subject: Re: smart and automatic use of dmix and dsnoop - feature suggestion.
Date: Mon, 17 Nov 2003 01:37:02 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200311170137.02755.mark@egghead.free-online.co.uk>
References: <200311141221.hAECLqlT003018@oud.linuxaudiosystems.com> <200311141511.22130.mark@egghead.free-online.co.uk> <s5hy8uj55m6.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hy8uj55m6.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 14 Nov 2003 15:31, Takashi Iwai wrote:
> At Fri, 14 Nov 2003 15:11:22 +0000, Mark Hubbard wrote:
> > On Friday 14 Nov 2003 13:20, Takashi Iwai wrote:
> > > as a future plan, we'll define dmix as default for el-cheapo
> > > soundcards, but e.g. not for sb live, which supports such a function
> > > on hardware.
> >
> > And what is your definition of an "el-cheapo" soundcard? :)
>
> what requires dmix plugin :)

In that case, Audiotrak, Terratec and M-Audio sound cards are "el-cheapo", and 
Creative sound cards are "high quality"!

> > I object to this future plan as even users of consumer soundcards do not
> > necessarily want everything resampled to 48 KHz in software by default
> > with the inherent sound quality degradations.
>
> hmm, we can implement it in a bit more clever way.  for example,
> starting dmix with the sample rate of the first running process sets
> (with lower boundary, e.g. the rate must be >= 44100).  in 99% time of
> typical desktop usage, audio apps run alone, and no conversion will be
> necessary.
>
> of course, we need to fix the race condition, etc, to realize that.

Ah, I see, the "default dmix" will NOT have a fixed sample rate and as such it 
will work more like Window's KMixer. ;)



-------------------------------------------------------
This SF. Net email is sponsored by: GoToMyPC
GoToMyPC is the fast, easy and secure way to access your computer from
any Web browser or wireless device. Click here to Try it Free!
https://www.gotomypc.com/tr/OSDN/AW/Q4_2003/t/g22lp?Target=mm/g22lp.tmpl
