From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: [PATCH] HDSP rms and peak registers correct offsets (was: Re:hdsp driver)
Date: Mon, 3 Mar 2003 06:23:01 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGGEHPBJAB.mknecht@controlnet.com>
References: <1046648582.1702.9.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1046648582.1702.9.camel@satellite.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Thomas,
   Will this work cover the HDSP 9652 also, or is that different and has to
wait?

Thanks,
Mark

> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Thomas
> Charbonnel
> Sent: Sunday, March 02, 2003 3:43 PM
> To: Paul Davis
> Cc: alsa-devel
> Subject: [PATCH] HDSP rms and peak registers correct offsets (was:
> Re:[Alsa-devel] hdsp driver)
>
>
> On Sun, 2003-03-02 at 21:24, Thomas Charbonnel wrote:
> > On Thu, 2003-02-27 at 19:43, Paul Davis wrote:
> > > i haven't had time today to get the patch for the hdsp ready. however,
> > > the new source works here (i have some CVS sync issues). i'll get it
> > > out to the list on monday (i'm gone for the weekend).
> > >
> > Did you sort out the rms register issue ? I'm currently implementing the
> > metering part of HDSPMixer and the rms values returned are obviously
> > bogus.
> >
> > Thomas
>
> Ok, I sorted it out myself, the offsets for the rms and peak registers
> were wrong. Sorry Paul, I could have seen this much earlier if I had
> done more extensive tests: I kept on testing inputs 1 and 2 while the
> input rms offset pointed on input 3... :-\
>
> The correct offsets can be found in the attached patch.
>
> Thomas
>
>




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
