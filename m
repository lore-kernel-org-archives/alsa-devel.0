From: "Stephen Warren" <SWarren@nvidia.com>
Subject: Azalia/ICH6-HDA mixer support?
Date: Wed, 24 Nov 2004 12:56:16 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0033AD80D@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
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

Hi.

I've integrated the "azx" driver from ALSA CVS into my kernel tree, and
basically have it working.

I can copy the Windows files "tada.wav" and run "aplay tada.wav" - this
works fine.

This is on an Intel motherboard, and the BIOS says "VVPGI637" for the
BIOS ID, which I assume is the motherboard name, or related to it...

The problem I'm having is that alsamixer only shows the following three
columns:

"Line", "Mic", "Capture"

(no, scrolling with left/right cursor doesn't show any others!)

One thing I did notice - alsamixer usually displays text for "Chip" in
the top-left, but doesn't on this system - just "Card: ICH6 HDA" and
"Chip:" is left blank. Is it not detecting the codec chip correctly?

This implies that there's no mixer for the output channels?! Is this a
hardware limitation (always line level out or something?) or just
missing functionality in the driver, since it's very new?

Looking at ALSA CVS, I can't find any extra conf file entries required
for this board. I'm using both the library and associated
/usr/share/alsa from alsa-lib-1.0.7 without modifications.

Any pointers appreciated. Thanks.

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
