From: Peter Zubaj <pzad@pobox.sk>
Subject: Mixer control names out of control?
Date: Sun, 28 Nov 2004 10:00:23 +0100
Message-ID: <200411280900.iAS90NIP014838@www4.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: peter@developers.dk
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>First of all, the AC97 driver uses the name "IEC958 Playback SPSA".
What's wrong with "IEC958 Playback Volume"?

IEC958 Playback SPSA - this is not volume - this controls what AC97
slot will be used for spdif output.

AFAIK
simple mixer element !=3D kernel mixer control. simple mixer element can
containd 6 kernel controls (mayby more):
Playback Volume
Playback Switch
Playback Route

Capture Volume
Capture Switch
Capture Route

>Front,Rear,Side
I think there is not constraint on names, there is only recomendation.
On some cards you are unable to fit to default names, because you want
name something what has diffrent meaning as control on other card.
Have you better names for this ?

Peter Zubaj=0A____________________________________=0Ahttp://www.pobox.sk/ -=
 najvacsi slovensky freemail=0A=0A=0A


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
