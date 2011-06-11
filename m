From: Adrien Plisson <aplisson+music@stochastique.net>
Subject: icon utrack pro usb audio interface
Date: Sat, 11 Jun 2011 13:52:16 +0200
Message-ID: <4DF356F0.6010701@stochastique.net>
Reply-To: aplisson+music@stochastique.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from 97.mail-out.ovh.net (30.97.mail-out.ovh.net [178.32.123.79])
	by alsa0.perex.cz (Postfix) with ESMTP id DEB8A24158
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Jun 2011 13:52:24 +0200 (CEST)
Received: from mail420.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by 97.mail-out.ovh.net (Postfix) with SMTP id 492E24AB9E6
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Jun 2011 13:53:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

hello,

i just bought an "icon utrack pro" usb audio interface 
<http://www.icon-global.com/ShowPro.aspx?ID=24>.

as expected, this interface is not supported under linux: it is not usb 
audio class compliant, even the midi port is not class compliant...

first, i would like to know if anybody ever managed to use this 
interface under linux: is there an existing driver ? a hack or patch 
that would allow the kernel to recognize this interface ? a specific 
module dedicated to this kind of interface ? i can't find any reference 
to this interface anywhere on the net...

anyway, while searching, i found that its firewire counterpart, the 
"firexon", has an experimental support on ffado. it seems that the 
firewire interface uses the bridgeco BeBoB chipset. given that some 
versions of BeBoB supports both firewire and usb, i suppose (but i may 
be wrong) that the "utrack pro" is also based on BeBoB. is there any 
other BeBoB based usb interface supported under linux ?

finally, i would proudly help the development of a specific driver for 
this interface: if anyone wants me to test some piece of code, or wants 
some information on this interface, don't hesitate to contact me. i am 
also a software developper, so i could help writing a module, but i 
first need to learn more about the alsa code base (actually, i don't 
know where to start...).

thanks a lot, and have a nice day !

-- 
rien
