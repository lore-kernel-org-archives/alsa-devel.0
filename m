From: "Stephen Warren" <SWarren@nvidia.com>
Subject: RE: azx: New board, can't get rear IO connectors to work.
Date: Fri, 17 Dec 2004 08:39:39 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B003CE0B9E@hqemmail02.nvidia.com>
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

From: Takashi Iwai [mailto:tiwai@suse.de]=20
> I tested the test board here (which has 3-stack + front-panel) and
> found that the surround doesn't work here, too.
> It's because the wrong initialization sequence when switched to the
> 6-channel mode.  After fixing it, the surround seems working well with
> 6-ch mode.  The patch is below (already committed to CVS).
>=20
> I guess the wrong pin control assignment or the unmuted amp volumes in
> somewhere in your case, too.

I spoke to the laptop manufacturer - they say they probably left a cable
unplugged when they did rework on the board - I tested Windows and rear
sound doesn't work there either...

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
