From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Fw: [Bug 76413] arts does not follow ALSA API
Date: Tue, 9 Mar 2004 23:03:02 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040309230302.2b40864a.mista.tapas@gmx.net>
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


Might be of interest..

Begin forwarded message:

Date: 3 Mar 2004 12:13:15 -0000
From: Allan Sandfeld <kde@carewolf.com>
To: mista.tapas@gmx.net
Subject: [Bug 76413] arts does not follow ALSA API 


------- You are receiving this mail because: -------
You are a voter for the bug, or are watching someone who is.
      
http://bugs.kde.org/show_bug.cgi?id=76413      




------- Additional Comments From kde carewolf com  2004-03-03 13:13
-------
We would be happy to accept your patches. I've started to work on this
bug, but I know neither ALSA nor much of aRts.

Currently the ALSA-plugin in aRts only calls snd_pcm_poll_descriptors,
and uses the first returned fd there for later use in select. If I
understand you correctly we need to be able to handle multiple
file-descriptors, and can't be garantied that they have the right
direction?

Now how do we tell which of the returned descriptors are writefds and
which are readfds? The only solution I can think of right now is to
checks the revents and hope all the writable ones are already in a
POLLOUT state.

I am also worried about the ALSA-documentation which states the fds
returned by snd_pcm_poll_descriotors might be bogus.



-- 
to sign or not to sign, that is the question



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
