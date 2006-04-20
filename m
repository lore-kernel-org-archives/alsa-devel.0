From: "alasinski" <alasinski@rogers.com>
Subject: How to access vendor specific AC97 codec register ?
Date: Thu, 20 Apr 2006 11:05:38 -0400
Message-ID: <e28805$nlf$1@sea.gmane.org>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I need to do IO specific operation from UCB1400 on Snapper Arm board. This 
has to be done from C code as it is part of a larger project. All what I 
need is to be able to read and write content of the few vendor specific AC97 
codec registers: 0x5A,0x5C. I'm not interested with any other ALSA 
functionality.

I have ALSA installed and running with simple programs that can successfully 
open controller with snd_ctl_open () and list available control elements. 
This is basically J.C.Georgas sample I found. I can read content of all AC97 
registers by cat /proc/asound/card0/codec97#/ac97#0-0+regs. That assures me 
that all driver and lib parts are working. All what I need is to write a 
simple piece of code ....

However, I spent 2 days reading through ALSA back and forth and I find this 
task very daunting to say at least. For one things I was not able to find an 
architecture document explaining how parts of ALSA work, to be able to find 
some sort of direction. There are samples dedicated to solving some of a 
problems, unfortunately not my problem. Man pages and reference are only 
little more then code browsing. Tutorials explain in brief what I don't need 
to know. In summary: typical situation when you are tasked with something 
that is off main stream.

I have an inkling that I should prepare UCB1400.conf file to define control 
elements that map to the registers (how ?). Then I should be able to 
snd_ctl_elem_read() or .._write() to them. Perhaps there is other way 
around: something like making ioctl() call on a driver directly w/o 
libasound. I'm in lost.

I will appreciate any suggestions and helpful hints

cheers
-al

a l a s i n s k i @ r o g e r s . c o m





-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
