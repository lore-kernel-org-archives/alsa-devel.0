From: sbahling@t-online.de (Scott Bahling)
Subject: Debugging driver modules
Date: 30 Nov 2002 16:27:43 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1038695263.19113.12.camel@vermin2.joe.net>
Reply-To: sbahling@mudgum.net
Mime-Version: 1.0
Content-Type: text/plain
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
List-Id: alsa-devel@alsa-project.org

Hello-

I have a STAudio DSP24 mkII and I have noticed that recent changes(after
NOV 13) in the CVS creates an ICE1712 driver that locks up my kernel.
Instead of just complaining about this problem I thought I might try to
narrow down the location in the driver that is causing the lockup.

Does anyone have any tips on debugging the driver modules? Is anyone
using a debugger to do this? I have looked at UML, but I am not sure if
there is a way to access the sound hardware with it.

Thanks,

scott



-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
