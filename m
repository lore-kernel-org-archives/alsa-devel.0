From: Paul Davis <pbd@Op.Net>
Subject: interesting msg on vst-plugins plus a url reference
Date: Tue, 05 Mar 2002 06:30:03 -0500
Message-ID: <200203051629.LAA07672@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I thought this was an interesting message, of some relevance
for the discussions we've had over ALSA and JACK etc. I would also
recommend 

   http://www.linuxpower.org/display.php?id=216

which is a really good and insightful article on pitfalls with the
development of SGI's dmSDK API (mostly video focus, but some mention
of audio, and lots of relevance to audio).

--p

------- Forwarded Message

Date:    Tue, 05 Mar 2002 08:07:10 -0800
To:      <vst-plugins@lists.steinberg.net> (VST PlugIns)
Subject: [vst-plugins] Re: VST DirectX Plug-in Wrapper

Yes, there's a substantial difference.

DirectX is far more flexible, which seems to translate into a substantial
weakness rather than a strength. It's baroquely complex, and rarely does
what it should, as anyone will tell you who has ever tried to build a
connection graph. DMOs only partially address the problem. 

DirectX's format flexibility also seems to be a liability. In practice, the
file filters don't work (the MP3 decoder, for example connects only
sporadically, and other decoders have well known bugs that crash systems
when you try to do simple things like enumerate or use installed audio
filters), so claims of superior handling of compressed files fail in actual
practice. 

The fact that DirectX supports, and actually has a significant preference
for integer formats is also a huge liability. Better just to dictate the use
of floating point (as VST does) and avoid the issue altogether. 

Also significantly missing from the DirectX suite is synthesizer support.
Although the Microsoft DDKs do occasionally provide sources for DirectX
synthesizers, the current versions in the DDK do not work with any known
application (not even Direct Music Producer). Cakewalk's DXi extensions do
address the problem, but really, the olnly similarities between DirectAudio
and DXi is that both are based on COM. Strictly speaking, the Microsoft DX
standard is all but useless for sequencers, and provides no real support for
synths. 

VSTs do seem to have design restrictions that are annoying. But frankly,
most of these restrictions occur in areas that DX/DXi has fumbled badly
anyway. 

I see the trade-off as follows: both do more or less the same thing,
although DirectX is baroquely complex and rarely does what it should. VST is
less flexible, but, being purpose built, does exactly what it needs to and
no more in a reasonably capable manner. Since I'm fluent in both COM and
device driver design and implementation on the Windows platform, I feel that
I'm competent to declare authoritatively that DirectX's baroque complexity
isnt' a skin deep problem: it comes about from insane overdesign that tries
to bring together three separate applciations (audio streaming, game
development, and audio production) into one framework -- something that
should never have been attempted in the first place. imho. Subseqent
band-aids that Microsoft has delivered which are supposed to address the
design insanity (like DirectMusic, and DMOs) seem to complicate things more
than they help, without actually consistently delivering the one feature
that everyone would really like: low latency audio. 

In short, VSTs are far easier to implement that DX-anything. And VSTs tend
to do what they are supposed to do -- unlike DX-anything.


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
