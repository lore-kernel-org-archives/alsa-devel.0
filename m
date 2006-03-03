From: Marcos Guglielmetti <marcospcmusica@yahoo.com.ar>
Subject: Reporting SB Live! bug: line's right channel not capturing with some kernels - modules
Date: Fri, 3 Mar 2006 21:58:19 +0100
Message-ID: <200603032158.20596.marcospcmusica@yahoo.com.ar>
Reply-To: marcospcmusica@yahoo.com.ar
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi!

	This is really odd:

With these kernel and alsa versions: The SB live! line's capture works 
fine
(it captures form both left and right channels)

Linux 2.6.11-1-386 #1 Mon Apr 25 01:18:07 UTC 2005 i686 GNU/Linux

Alsa version:

apt-cache policy alsa-base
alsa-base:
  Installed: 1.0.9b-4

------------------------------------------------------

Using these kernel and alsa versions: The SB live! line's capture works 
bad:
(it captures only from the line's left channel)

Linux 2.6.14-1-multimedia-386 #1 PREEMPT Sat Dec 10 16:52:12 CET 2005 
i686 GNU/Linux

Also with 2.6.13-1-multimedia-386 from aGNUla /DeMuDi

apt-cache policy alsa-base
alsa-base:
  Installed: 1.0.10-1
-------------------------------------------------------
Here it fails too:

uname -a
Linux 030users 2.6.15.4-rt #1 PREEMPT Fri Feb 17 18:55:02 EET 2006 i686 
GNU/Linux

apt-cache policy alsa-base
alsa-base:
  Installed: 1.0.9b-4


--------------------------------

	Someone knows what is happening with this odd problem?

	


-- 
Marcos Guglielmetti  
Coordinador del desarrollo de Musix GNU+Linux 
(www.musix.org.ar) 
Mirrors: (www.musix.distrux.net) (www.pc-musica.com.ar/musix) 
(www.k-maleon.com/musix)

	
	
		
___________________________________________________________ 
1GB gratis, Antivirus y Antispam 
Correo Yahoo!, el mejor correo web del mundo 
http://correo.yahoo.com.ar 




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
