From: Nathaniel Gray <n8gray@caltech.edu>
Subject: Re: [BUG] intel8x0: arecord doesn't work
Date: Wed, 27 Aug 2003 12:26:19 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308271226.19663.n8gray@caltech.edu>
References: <bihp12$g4o$1@sea.gmane.org> <s5h1xv7xo11.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1xv7xo11.wl@alsa2.suse.de>
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

On Wednesday 27 August 2003 05:50 am, Takashi Iwai wrote:
> At Wed, 27 Aug 2003 01:10:06 -0700,
>
> Nathan Gray wrote:
> > I'm trying to record from the built-in mic in my laptop (Dell
> > Inspiron 4150) but it doesn't seem to work right.  If I select
> > "Mic" as the capture source and max out the volume then when I tap
> > the microphone I can hear it loud and clear in my headphones.  Then
> > I try:
> >
> > [n8gray@golux patches]$ arecord -d 5 foo.wav
> > Recording WAVE 'foo.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
> >
> > I tap the mic a few times as this is running.  I hear the taps
> > great while recording, but playing back foo.wav I just hear static,
> > with the taps barely audible.  Adjusting the recording levels
> > doesn't change anything.
>
> what about hw:0,1 ?

[n8gray@golux patches]$ arecord -D hw:0,1 -d 5 foo.wav
Recording WAVE 'foo.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
arecord: set_params:809: Sample format non available

I get the same result for -D intel8x0 and -D hw:0.

-- 
>>>-- Nathaniel Gray -- Caltech Computer Science ------>
>>>-- Mojave Project -- http://mojave.cs.caltech.edu -->




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
