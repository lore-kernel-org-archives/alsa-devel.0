From: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Subject: RE: ALSA vs OSS/free
Date: Thu, 7 Mar 2002 15:14:01 -0000
Message-ID: <a680kf$fli$1@quimby2.netfonds.no>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.44.0203071529210.923-100000@ecabase.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Kai Vehmanen <k@eca.cx>, alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net, linux-audio-dev@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

As a programmer, alsa is just much easier to use.
alsa provides a consistent api interface for all sound cards thanks to the
alsa-lib. (shared user space code)
So, if I write an app for my sound card, I can be pretty sure the app will
work on all other sound cards.

With OSS/Free, hardly any of the drivers support all the OSS api features,
so the application has to do work arounds if certain api features are not
present. To me that is messy.

Alsa should always be considered as a low level driver to drive the hardware
and nothing more.
Then one can put ardour and jack on top, for extra features.

Cheers
James


> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Kai Vehmanen
> Sent: 07 March 2002 13:56
> To: alsa-devel@lists.sourceforge.net; alsa-user@lists.sourceforge.net;
> linux-audio-dev@music.columbia.edu
> Subject: [Alsa-devel] ALSA vs OSS/free
>
>
> Why is ALSA the better alternative? That's a question I've been asked
> quite a few times recently. Below is a reply I just wrote to
> ecasound-list. I'd be very interested in hearing your comments on this
> issue. Have I missed some important points?
>
> One thing that seems be causing a lot of confusion is performance and
> latency comparisons. While ALSA provides many things that make it easier
> for developers to reach better performance and low latency, similar
> results can be achieved with well-written OSS drivers and applications.
>
> Only in few specific cases (multichannel noninterleaved soundcards, etc)
> ALSA provides a clear advantage. From marketing point of view I think it's
> wise to acknowledge this. But there are other reasons why future looks
> bright for ALSA:
>
> --cut--
> > Philosophically (and technically) speaking, are there real
> advantages for
> > me to install alsa (other than the above) when OSS/free works for me? I
>
> If OSS works for you, then no. ALSA's primary advantages are:
>
> [common]
> - separation of kernel and user-space code [all]
> 	- ALSA library can provide more functionality to
> 	  applications (format conversions, sharing soundcard
> 	  resources, dsp plugins)
> 	- benefits ALSA-native apps
> [alsa-kernel/alsa-driver]
> - better driver architecture
> 	- more shared code between drivers for
> 	  different soundcards
> 	-> fixes and improvements to common code affect all
> 	   drivers
> 	-> drivers behave more uniformly
> 	- benefits both ALSA-native and apps using OSS-emulation
> - support for pro-level soundcards without performance problems
> 	- for instance handling devices that only support
> 	  noninterleaved buffer layout
> 	- befefits ALSA-native apps (and in some cases also
> 	  apps using OSS-emulation)
> [alsa-lib]
> - better API for applications [alsa-lib]
> 	- more flexible configuration of various parameters
> 	- well-designed API for acquiring realtime status
>           information (for various playback/capture
> 	  synchronation purposes)
> 	- benefits ALSA-native apps
>
> So shortly put, ALSA provides a better framework for writing drivers and
> for developing audio applications.  When comparing OSS/Free and ALSA from
> an end-user's point of view, it comes down to the quality of the drivers
> for the soundcard type in question, and the specific applications that are
> used. Some OSS/Free drivers are very good and support all OSS API
> features. If this is the case and all apps seem to work ok, you don't have
> much to gain from switching to ALSA... yet.
>
> But because of the abovementioned reasons, over time ALSA drivers and
> applications will become better than OSS versions. I think this is
> inevitable.
> --cut--
>
> --
>  http://www.eca.cx
>  Audio software for Linux!
>
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
