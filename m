From: Ilia Mirkin <imirkin@MIT.EDU>
Subject: Re: [Alsa-user] Re: Re: SB Live! PCM control
Date: Sat, 05 Feb 2005 21:10:47 -0500
Message-ID: <1107655847.1336.20.camel@IMIRKIN.MIT.EDU>
References: <420270C1.3000706@voicenet.com>
	 <1107457227.7256.37.camel@krustophenia.net>
	 <4202A72C.3000007@superbug.co.uk>
	 <1107645609.7256.73.camel@krustophenia.net>
	 <1107653698.1333.5.camel@IMIRKIN.MIT.EDU>
	 <1107654754.7256.115.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1107654754.7256.115.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

:) It's not perfect. However if the app were to scale it internally,
you'd run into all sorts of integer crappiness problems (rounding, low
resolution for small values, etc). It does only affect software
applications, and not stuff like direct CD audio and so on. However I
guarantee that on my setup, the PCM volume control, ALSA or OSS, has 0
effect on the volume coming out of the thing controlled by "Wave
Surround".

In theory you are right, every application should be able to tell the
mixer how to mix in ITS contribution to the audio, but it is a little
presumptuous to have to ask everyone to rewrite their applications to
work with some new interface. OSS has been standard for a while, and I
feel that there should be support in ALSA for "the old way" (which there
is, except that the mixer controls don't behave as I might expect).

I have an SB Live! 5.1 card

00:09.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev
07)

or if you want the exact PCI id:

00:09.0 Class 0401: 1102:0002 (rev 07)

I haven't been able to get ld10k1 to work - it dies with something about
being unable to peek. This could be because I run the ALSA that comes
with the 2.6.10 kernel (claims to be 1.0.6). It could be because I don't
have an Audigy card, though it sounds like SB Live! users have been able
to run it.

I'm also not sure what you refer to when you say "EMU10K1 PCM Volume"...
I just have something called "PCM" in alsamixer, along with a dozen
other controls. "Wave Surround" is the only one that does anything to
the volume being played out of the rear jack on the card.

And while I agree that A and B should be able to be independent, I also
feel that there should be a way for them to behave just as they do in
the OSS driver, i.e. mirrored, with independent relative level controls,
but both controlled by the PCM volume.

I'm glad that I started this whole discussion, and it sounds like a lot
of users have problems similar to mine. There should probably be a
couple of "default" configurations, e.g. mirrored, independent,
surround, that load up the proper DSP code automatically, and then if
someone has a REALLY weird setup, then they can screw around with ld10k1
and so on.

---
Ilia Mirkin
imirkin@mit.edu

On Sat, 2005-02-05 at 20:52 -0500, Lee Revell wrote:
> On Sat, 2005-02-05 at 20:34 -0500, Ilia Mirkin wrote:
> > The way that most (OSS at least) applications work is that they grab the
> > PCM volume control and use that instead of actually adjusting the
> > amplitude of the PCM samples. The problem that I was originally having
> > is that the Wave Surround level is not effected by the PCM level,
> > whereas the Master output is.
> 
> How do they know which control to use?  Just blithely grabbing the
> master seems boneheaded.  What if another application is playing sound
> at the same time?  I certainly don't want or expect the volume control
> in mplayer to affect the output levels of other applications.  For
> example a configuration that uses the front and rear speakers as
> indepenent stereo PCMs.  Lowering the volume in the app A that's playing
> to the front speakers should NOT affect the volume in app B that's
> playing to the rear speakers.
> 
> The emu10k1 has a per PCM volume control ("EMU10K1 PCM Volume") that
> does the Right Thing in this situation.
> 
> Lee
> 



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
