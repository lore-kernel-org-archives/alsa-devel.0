From: "Ivica Bukvic" <ico@fuse.net>
Subject: [lack of] dynamic detection/loading of modules
Date: Wed, 26 Feb 2003 22:22:48 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <001d01c2de0f$8715e530$aa1f830a@ICO>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

After several correspondence between the CCRMA's Linux audio guru
Fernando and myself, I realized that Alsa really needs (as Fernando has
pointed out) list of modules currently loaded that would enable users to
simply plug in devices as needed and then have them immediately
recognized by Alsa without having to restart the alsasound server (or
perhaps have it restart automatically -- although now that I think of
it, this would be a hack-like approach that would wreak havoc among the
open apps talking to the audio resources at the time of its restart).

The typical example of problems that arise due to fact that this is not
available is with the Midisport 2x2 USB interface (something that is
applicable to any other hot-pluggable audio/midi interface).

Scenario 1:

If one enables loading of the Midisport 2x2 interface at boot time, then
the device loads before the actual soundcard (since alsasound service
starts after the USB service -- something that is apparently not
configurable). This results in an absent /dev/dsp (since midisport is
the default audio device and it has no audio capabilities) and a
hardlock if pd is spawned having Midisport being the 1st audio device
(and possibly a plethora of other, yet-to-be-discovered side-effects).
Having index values in modules.conf does not solve the problem, since
USB still starts before Alsasound does, and therefore USB hw is to the
best of my knowledge unaffected by it. The only solution is to hook-up
your USB equipment after the alsasound service starts (this is ok, but
not acceptable as a 100% user-friendly experience, since one that does
not know of this issue, such as myself a week ago, ends up crashing the
machine X times before realizing the problem, and that is if they ever
get to realize it -- I consider myself relatively Linux/Alsa literate,
and yet even I was feeling lost there for a while).

Scenario 2:

On the other hand if one blacklists loading of the snd-usb-midi at the
moment that Midisport 2x2 is detected (at boot-time) in order to have
Alsa configure itself properly through the modules.conf script
afterwards, this means that if one does not plug in the Midisport 2x2
before alsasound service starts (at boot-time), they are forced to
restart alsasound service in order to have their USB hw functional
(which may again wreak havoc on the open audio apps using audio
resources and furthermore requires relatively good knowledge of the
underlying problem as well as the concept of Linux services etc.).


Both of the situations are apparently unacceptable from an average
end-user standpoint since they imply that the end-user needs to know
these quirks in order to have basic (ok, not-so-basic :-) Alsa's
functionality.

Here's the excerpt from Fernando's comments which suggest a potentially
easy fix to the problem, something that would make Alsa a _lot_ more
user-friendly.

<quote>

"The proper fix to all this problem would be to modify the alsasound
startup script to be able to load the missing modules (ie: start a
partially started module load). There was a thread in one of the mailing
lists about this and to do it cleanly it would be nice to have available
in /proc/asound the list of modules currently loaded. That is not
available today (I think Takashi said he might add that)."

<end-quote>

Fernando mentions that there was already a thread on this issue and that
Takashi generously offered to do this at some point (and I am sure that
he's busy already as it is). However, it seems that this should be
something that needs more urgent attention, especially now that we have
seen a rapid increase in support of hot-pluggable audio hardware
(usb/pcmcia, and hopefully soon the firewire stuff).

I am posting this not to flame, but rather to expose the issue since a
lot of other users out there have experienced aforementioned problems,
but are not aware of the fact that there is no absolute fix for it. I am
also posting this in hopes that doing so will expedite this problem's
resolution, since its existence definitely limits Alsa's
user-friendliness (and hence perhaps its faster adoption).

I am not sure how OSS stands on this issue, but then again that should
not matter. Alsa is trying to raise the bar in the Linux audio quality
and this is definitely one of important usability issues that require
(IMHO) urgent attention.

Thank you! Sincerely,

Ivica Ico Bukvic, composer, multimedia sculptor,
programmer, webmaster & computer consultant 
http://meowing.ccm.uc.edu/~ico 
============================ 
"To be or not to be" - Shakespeare
"To be is to do"     - Socrates
"To do is to be"     - Sartre
"Do be do be do"     - Sinatra
"2b || ! 2b"         - ?
"I am"               - God




-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
