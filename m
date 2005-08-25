From: Manuel Jander <manuel.jander@gmail.com>
Subject: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Thu, 25 Aug 2005 20:58:45 +0200
Message-ID: <1124996325.17363.6.camel@localhost.localdomain>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org>
	 <430B3EA0.1000903@netvigator.com> <s5hr7ck4lmt.wl%tiwai@suse.de>
	 <200508232340.46629.alien999999999@users.sourceforge.net>
	 <430DFC0D.1010502@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <430DFC0D.1010502@netvigator.com>
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

Hi,

On Fri, 2005-08-26 at 01:12 +0800, Raymond wrote:
> Alien wrote:
> > 
> > PS: i forgot the latest patch i had to try out.
> 
> Don't forget the latest patch "Fixed missing spin_unlock" on CVS .
> 
> > 
> > I'll do one patch to try out, and hope it doesn't require me to reboot this 
> > machine...
> > 
> > i'm using alsa CVS from some weeks ago, i think
> 
> Although I can play multiple mono sound streams on device 2 on my au8830.
> 
> I don't know why the connection routine of device 2 is disabled only on
> au8810 driver.
> 
> If you have any application using device 2 to playback (e.g. 3D demo in 
> vortexcontrol), wierd things may happen on au8810 since some of the 
> route and mixer of device 2 playback stream has not been assigned.

The WT and A3D subsystems for AU8810 are disabled, because:

- The AU8810 does not has any WT engine.
- The AU8810 A3D slices/sources register addresses have not been
confirmed and seem to be wrong. It looks like the AU8810 has 8 3D
sources instead of the 16 that the AU8830 has, but further work is
required, starting with the disassemble of a AU8810 WDM driver, in order
to find out/conform the 3D slices/sources register addresses.


Best Regards
Manuel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
