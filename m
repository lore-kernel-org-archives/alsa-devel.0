From: Mark Knecht <markknecht@comcast.net>
Subject: Alsa-OSS - Pop at start of song update (rc2)
Date: Sun, 07 Dec 2003 10:03:15 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1070820195.3841.42.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,
   This is a small update on the problem I've seen with loud pops and
crackles at the start of audio when using Alsa's OSS emulation. As
background, using xmms I am unable to play about 99% of the mp3, ogg and
wave files I have without getting a very loud noise when first starting
the playback. The noise also happens every time I pause and restart the
playback. It also happens with pretty much every audio or video viewed
and played by Mozilla. mplayer, xine, plugger-5.0 all have default
setups that cuase this on my system. 

   However, an interesting aspect was that this does not ever happen
when playing any of these files with an Alsa application instead. Using
that as a clue, I tried using alsaplayer through the oss layer instead
of directly into Alsa, using

alsaplayer -o oss

It turns out that this NEVER causes the noise. All mp3, ogg and wave
files play correctly using alsaplayer through the OSS layer.

   I'm not sure what this says, really. If alsaplayer can talk to the
OSS layer correctly, then you could say that every other app I've tried
is bad and all those apps need to be recoded. On the other hand, if so
many apps fail in my system, then is the problem with the OSS emulation
interface and that needs to be looked at?

   I also tried building the alsa-xmms plugin, but it fails with
Alsa-1.0.0rc2, so I'll file bug reports on that elsewhere.


Thanks,
Mark

Postscript: 

   Without support from a developer somewhere who is interested in
solving this I understand that this is not going to go much further than
this message. The problem has been there, and I have been reporting it
in one form or another for over 8 months. No one has stepped up to solve
it specifically, and not being a developer this is about as much as I
can do. I don't know what else I can do to muster some interest in
solving it. This is an RME product, which is one of the 'preferred'
hardware manufacturers for Linux audio. It's burning me today. It will
burn others later.

   Clearly I get that this problem occurs on very few systems, so I get
that it's not high priority. Maybe there's nothing that can get done
about it. That would be disappointing.

   From a practical point of view, this one problem pretty much causes
me to have to drop using Linux at all for browsing the web and is
forcing me back to Windows. I cannot handle super loud ugly noises at
the start of playing a simple 2-second wave file. A lot of what I do is
on the web, and every one plays badly on my system. Bummer...

   The only practical idea I can offer is that someone in the Alsa camp
should take up the task of developing a set of instructions for
configuring Mozilla. et. all, in such away as to make OSS not be used. I
think Alsa should support, but not depend on, OSS at all. Today it
depends on OSS by not providing clear info on how to use Alsa inside of
browsers.




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
