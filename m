From: alsa-devel@robdye.net
Subject: Fwd: Re: Names of things
Date: Wed, 15 Oct 2003 14:43:42 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1066254222.3f8dbf8ecaa9d@scorpio.lunarpages.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



This was intended for the whole list:


----- Forwarded message from alsa-devel@robdye.net -----
    Date: Wed, 15 Oct 2003 13:21:20 -0700
    From: alsa-devel@robdye.net
Reply-To: alsa-devel@robdye.net
 Subject: Re: [Alsa-devel] Names of things
      To: tsw@johana.com

Quoting Tom Watson <sdc695@yahoo.com>:

> 
> I would also like to have a "note" explain somewhere that "LFE" is a
> synonym for "Sub_woofer"
> 

LFE is not a synonym for Subwoofer, and should not be used as such.  It
is a bit confusing and due mostly to histroical reasons (film
soundtracks).  The two are as follows:

LFE -- the ".1" channel in a 5.1, 7.1, etc. _delivery_ medium.  It is
supposed to contain only high-level (loud) bass material (120Hz absolute
max, usually the cutoff is lower), that is _not absolutely essential_ to
the program.  It may contain nothing at all.  In all cases bass material
must be present (probably at a reduced level) in the main channels as well.

subwoofer -- the channel that feeds a subwoofer, if present, in the
_listening environment_.  The subwoofer is expected to handle bass
material that any of the other speakers are not capable of handling. 
Thus, bass from any of the main channels may be diverted to the subwoofer.

If there is no subwoofer present, and the main speakers are capable of
handle extreme bass, the LFE channel may be diverted to main speakers. 
If there are no speakers capable of handling extreme bass, the LFE
channel may be discarded.

The process of converting the 5.1 channels on the delivery medium to the
appropriate speaker feeds (possibly including a subwoofer) is handled by
a system known as "bass management".  Any Dolby Digital decoder is
required to have some form of bass management, though it may be very
rudimentary and not adequate for the actual listening setup.

If you want the full explanation, search the archives for the
sursound@music.vt.edu mailing list, or go there and ask.  But, be
prepared for a barage of answers and maybe a minor religous war.

Also see: http://www.dolby.com/tech/c.in.0011.LFE.pdf

--Rob


----- End forwarded message -----





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
