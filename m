From: Giuliano Pochini <pochini@shiny.it>
Subject: module is not unloaded when probe fails
Date: Mon, 22 Mar 2004 22:08:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040322220826.1be9799a.pochini@shiny.it>
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
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org



When I try to load a module and it fails (snd-darla20 in this case) the
module is not unloaded. IIRC it didn't happen some months ago, but I have no
idea what is the cause because I changed a lot of stuff in the meantime
(kernel, compiler, modutils...). Is this the expected behaviour ?

[Giu@Jay Giu]$ uname -a
Linux Jay 2.6.3-ben2 #10 SMP Sun Mar 14 21:46:34 CET 2004 ppc unknown


[root@Jay Giu]# dmesg
[...]
PCI: Enabling device 0001:01:15.0 (0004 -> 0006)
[...]
Echoaudio: probe of 0001:01:15.0 failed with error -1
[root@Jay Giu]# lsmod
Module                  Size  Used by
snd_darla20            67908  0
snd_pcm               137692  1 snd_darla20
snd_timer              33000  1 snd_pcm
snd                    72800  3 snd_darla20,snd_pcm,snd_timer
snd_page_alloc         14436  2 snd_darla20,snd_pcm
therm_windtunnel        9748  0


--
Giuliano.



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
