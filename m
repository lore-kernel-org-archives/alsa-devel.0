From: Mark Swanson <mark@WebServiceSolutions.com>
Subject: smix plugin available?
Date: Mon, 25 Nov 2002 20:16:47 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200211252016.47211.mark@WebServiceSolutions.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hello,

A gentleman by the name of Abramo Bagnara recently stated he may have some 
code that would kick-start the development of the smix plugin. I think this 
is a very useful and increasingly important component. Abramo stated he had 
no problem releasing it, but I could not find where or if he did so.

If Abramo - or anyone - could point me in the right direction I would 
appreciate it.

The reasons I'm looking for this is to solve the following problems with 
soundcards that do not have a hardware mixer:

When using Gnome/KDE (esd/arts) no programs can access the sound device unless 
they are written to use arts/esd/jack/etc...

It is not logical for every program to write support for esd, artsd, jack, 
alsa, etc. Programs should write to ALSA and let ALSA do software mixing if 
required. Windows provided this since DirectX (3?). Solaris provides this too 
(esd apparently doesn't block on Solaris).

I believe that the majority of sound cards in use (on Linux) do not have 
hardware mixing, and that this is already a large problem that will continue 
to get larger.

One of the big reasons this is affecting me is that Java sound will not work 
unless you have a hardware mixer. My understanding is that the Sun folks seem 
to think that it is wrong to have to implement many different ways to create 
sound when the sound library (ALSA) should do it for them - the way it works 
in Windows/Solaris. I completely agree with them.

Cheers.

-- 
Schedule your world with ScheduleWorld.com
http://www.ScheduleWorld.com/



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
