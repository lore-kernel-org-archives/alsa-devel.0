From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Fw: [Bug 76413] arts does not follow ALSA API
Date: Fri, 19 Mar 2004 16:09:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040319160934.7afc75e8.mista.tapas@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

might be of interest to you guys... 

Begin forwarded message:

Date: 19 Mar 2004 13:50:08 -0000
From: Allan Sandfeld <kde@carewolf.com>
To: mista.tapas@gmx.net
Subject: [Bug 76413] arts does not follow ALSA API 


------- You are receiving this mail because: -------
You are a voter for the bug, or are watching someone who is.
      
http://bugs.kde.org/show_bug.cgi?id=76413      
kde carewolf com changed:

           What    |Removed                     |Added
-----------------------------------------------------------------------
-----
             Status|NEW                         |UNCONFIRMED



------- Additional Comments From kde carewolf com  2004-03-19 14:50
-------
Okay, having researched the problem. The reason that dmix doesnt work
with aRts has nothing to do with how we use the alsa API because all our
assumptions are still true. snd_pcm_poll_descriptors() returns exactly
one descriptor, but calling select upon this descriptor no matter how it
is done will _never_ return. In other words the reason it doesnt work is
that dmix is broken!

I've looked a bit at how other projects use ALSA, and it seems we could
make it work if we used another API and disregarded the broken
descriptors alltogether, in other words if we rewrite the entire
audio-subsystem of aRts to work-around a bug in ALSA (I have no
intention of doing so).

Btw. I did make playback over dmix work, but the it required using
timing events rather than IO-events and thus CPU-usage was unacceptable.



-- 
kT



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
