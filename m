From: Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Subject: Hammerfall (hdsp) initialization problem
Date: Fri, 23 Jul 2004 14:32:48 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1090607568.17750.7.camel@modemcable182.55-70-69.mc.videotron.ca>
Mime-Version: 1.0
Content-Type: text/plain
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I'm having problems getting the snd-hdsp driver to load. I have a PCMCIA
adaptor for an RME Hammerfall card and whenever I insert it, I get this
(dmesg):

PCI: Enabling device 0000:03:00.0 (0080 -> 0082)
RME Hammerfall DSP: no buffers available
RME Hammerfall DSP: probe of 0000:03:00.0 failed with error -12

Actually, sometimes it loads fine and sometimes it doesn't. I noticed
that the sooner I insert the card (after boot), the more likely the
module is to load (though it's never 100%). I'm running a 2.6.7 kernel
(don't know what version of the drivers come with it) with the swsusp2
patches and preempt enabled. I don't think it changes anything, but I
have two non-standard config options: PAGE_OFFSET=0xb000000 (support for
1G of mem without the 4G overhead) and HZ=100.

I'm running this on a Dell D600 laptop (Pentium-M 1.6 GHz) with 1GB RAM.

	Jean-Marc

-- 
Jean-Marc Valin <Jean-Marc.Valin@USherbrooke.ca>
Universite de Sherbrooke



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
