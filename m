From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Trivial hdsp.c patch to support rev 50 cards
Date: Wed, 30 Jul 2003 14:18:56 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGKENFCNAB.mknecht@controlnet.com>
References: <20030730191002.M68372@vertice.ca>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030730191002.M68372@vertice.ca>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dan Nyborg <nyborg@www.vertice.ca>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
> however, when i try to play something with alsaplayer or aplay, my system
> freezes after 2 sec to 2 min of playback... sometimes i can get through a
> whole file, sometimes only partial, but an eventual lock-up is
> inevitable. i
> have not tried sending anything other than stereo, 44100kHz, 16bit files.

Dan,
   I'm using a 'similar' driver from Thomas, but not the identical driver,
and with the HDSP 9652, not the MultiFace. Using aplay and MONO wave files
I'm fine. Using anything in stereo results in all sorts of problems,
including hard locks or at the minimum no further sound. Only a reboot fixes
this for me.

   Could you try a mono file and see what results you get?

   alsaplayer sometimes works for me. For about 30 seconds I'll get sound,
and then the sound stops and doesn't work until a reboot.

- Mark






-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
