From: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Subject: Re: RC7 and CS46xx (GTXP) -> Terratec XFire
Date: Sun, 02 Feb 2003 17:22:43 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E3D45D3.8010303@gmx.de>
References: <20030201144858.0479188a.flame@home.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030201144858.0479188a.flame@home.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Richard Olsson <flame@home.se>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Richard Olsson wrote:

>Something between CVS 2002-12-18 and RC7 seriously broke the amplifier
>stuff for me on my GTXP - sound is very disorted and volume is very low.
>It's different from the troubles RC6 gave me though.  I'd guess it's
>the recent amplifier patch that was applied to the CS46xx driver.
>
>Only oddity I see is in dmesg:
>ALSA ../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:415: cs46xx: failure waiting for FIFO command to complete
>
>I'll stick to the 2002-12-18 CVS for now:)
>
>  
>
The same warning in dmesg with my Terrartec DMX XFire. But everything 
seems to work (OK) like 2002-12-09-CVS + 2003-01-05-patch. What does 
this warning mean. Should I ignore it?
TIA
 fe



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
