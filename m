From: "Stephen Warren" <SWarren@nvidia.com>
Subject: azx: New board, can't get rear IO connectors to work.
Date: Thu, 16 Dec 2004 13:17:02 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B003CE0B10@hqemmail02.nvidia.com>
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

I'm attempting to get audio up and running on a new system with the
HD-Audio/ALC880.

Part of the connectivity is:

Line-2 pins are output, and connect to both the internal speakers on the
laptop, and a headphone jack. If I configure NID 0x1b as output, and NID
0x13 to select the "front" input source, then program mixer NID 0x0c
correctly, and send data to DAC 0x02, then I hear audio on the speakers
(or headphones) just fine. Alsamixer correctly controls the volume.

However, there are also 3 audio jacks on the back of the system -
namely, front, surround and center/lfe. These are allegedly connected to
the front, surround and center/lfe pins on the ALC880 (the side-surround
pins are unused).

Now, I know DAC 0x02 and mixer 0x0c are working fine, since they affect
the internal speakers when routed through 0x13/0x1b.

However, if I program pin NID 0x14 (front out) just like I programmed
pin NID 0x1b (line2), then I can't get anything to come out. As an
experiment, I tried every possible programming of pin NID 0x14, and
nothing works!

The same experiment using DAC 0x03/0x04 and associated output pins
doesn't work either. I've sat running speakertest, plugging both
headphones and regular PC speakers into all the audio jacks, and no
luck.

(I've also tested all the other DACs and mixers by routing them out the
line2 output, so I know the problem only lies with the other output pin
configuration, or beyond somewhere on the PCB)

Any ideas of anything else I might try to debug this?

Thanks.

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
