From: Anders Torger <torger@ludd.luth.se>
Subject: Re: RME96 patch broke
Date: Wed, 29 Jan 2003 18:22:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301291822.48601.torger@ludd.luth.se>
References: <200301282124.h0SLOU690158@mail.mega.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200301282124.h0SLOU690158@mail.mega.nu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Pouzzner <douzzer@mega.nu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tuesday 28 January 2003 22.24, Daniel Pouzzner wrote:
> >> >so you have
> >> >tested with an old ALSA and the new driver (rme96.c) and that
> >> > does not work?
> >>
> >> Yuppers.  Pinned it down pretty carefully.
> >>
> >> >Is it double speed capture from analog, or from digital input you
> >> > are having problems with?
> >>
> >> Analog.  Haven't tested digital for the bug yet.
> >
> >Uhm... I have some problems. It was ages ago I used the analog
> > input, and now when I test it, I can't get it to work at all... All
> > I get is noise. Could you confirm what does work with the analog
> > input, even with the new driver? I suspect that my hardware is
> > broken...
>
> Oh no!
>
> Alright, I carefully ran the gamut to pin down what was broken.
> Single and double speed analog playback works fine.  Single speed
> analog capture works fine.  (Double speed playback fed back into
> single speed capture, works fine.)  Double speed capture is messed
> up, fed by either single or double speed playback.  If you need more,
> I could post some spectrum displays of the breakage.

The patch is not very big, but anyway, I think my plan is to split it up 
in a series of small patches, and I send you 10 or so rme96.c, which 
you test in order, and note when it fails. It will mean some boring 
work for you, but since my hardware really seems to be broke, I think 
this is the fastest way to find the problem.

I shall also analyse the code even more closely, perhaps I can find 
something through inspection.

I'll get back to you.

/Anders Torger


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
