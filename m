From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Which API to use for simple clients?
Date: Sat, 03 Jan 2004 14:29:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opr07br2w0q1sf88@mail.broadpark.no>
References: <20040102181512.9272.3@llama.ing-simmons.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040102181512.9272.3@llama.ing-simmons.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Nick

Since you're looking into different alternatives, have you considered=20
PortAudio (www.portaudio.com)? The ALSA implementation of v19 (developmen=
t=20
branch) is well developed, and fairly stable from what I can see (being=20
one of the developers). There hasn't been a lot of feedback, but my own=20
testing hasn't turned up any bugs in a while. PortAudio also offers two=20
different interfaces to the programmer, both blocking and callback=20
interfaces are completed for the ALSA implementation. So you can choose=20
whichever suits your application the best. At the same time, should you=20
wish to write cross-platform programs, PortAudio supports different=20
platforms. I don't know the current state of all the implementations, but=
=20
Windows MME and ASIO should be well functional and SGI IRIX seems to be=20
coming along.

Hope this helps

Arve Knudsen

On Fri, 02 Jan 2004 18:15:12 +0000, Nick Ing-Simmons=20
<nick@ing-simmons.net> wrote:

>
> I have two Audio related projects that need updating.
>
> 1. "rsynth" formant based text-to-speech synthesis
>
> 2. Audio::* Perl modules.
>
> Both have existing /dev/dsp style backends at present, which have been=20
> working
> fine. But recently (SuSE 9.0 install?) when run under ALSA emulation of
> /dev/dsp they both started producing segfaults - "after program had=20
> exited",
> (neither valgrind nor gdb can give any info on the fault).
>
> So I decided it was time to do a native ALSA backend(s).
> I have rsynth backend working, and perl Audio:: one almost working.
> But before going forward I would like to solicit opinions on what
> is the "right" API to use.
>
> The Linux audio world seems to be in a state of flux with these options
> (please tell me if I missed any):
>
> 1. Venerable OSS stuff
>    - Widely available :-)
>    - Some cards have quasi or truely commecial drivers rather than
>      free / opensource ones :-(
>    - emulation via ALSA (at least as shipped by SuSE) seems broken :-(
>
> 2. ALSA
>    - Reasonably widely available :-|, and improving
>    - Opensource :-)
>    - Documentation is lacking :-(
>      Everything hinges on the
>      "Configuration Space" concept, but I can't find an explanation of
>      how that works. This is the sticking point with perl code - I can'=
t=20
> find
>      how to change the sample rate / channels, so _seems_ I need to
>      close and re-open.
>
> 3. JACK
>    - Gets lots of excited "this is cool" kind of coverage :-)
>    - realtime :-)
>    - Callback style not ideal for speech synthesis or play-from-file
>      of my simple apps. complex :-(
>
> 4. Enlightenment Sound Demon
>    - Seems to be used by KDE etc.
>    - haven't looked into it further.
>
> 5. Network Audio System
>    - Works on many platforms Linux/Solaris/X Terminals :-)
>    - X-like "imake" style rather than configure :-(
>    - Linux version still seems to be based on OSS - so recurse ;-)
>
> 6. Presumably there is some kind of telephony API as well, for sending
>    sound to incomming phone calls via modem / ISDN
>
> Complexity and callbacks don't scare me - I do perl/Tk after all!
> But this is a 2nd-string project so I don't want to do a lot of
> complex stuff for an API that is vanishing - I would rather either
> use a simple stable interface, or pitch in and help on the "comming"
> complex API.
>
> Suggestions anyone? (I just subscribed to both lists - so reply to your
> favourite list.)
>
>
>
>
>
>
>
> -------------------------------------------------------
> This SF.net email is sponsored by: IBM Linux Tutorials.
> Become an expert in LINUX or just sharpen your skills.  Sign up for IBM=
's
> Free Linux Tutorials.  Learn everything from the bash shell to sys admi=
n.
> Click now! http://ads.osdn.com/?ad_id=1278&alloc_id371&op=3Dclick
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
