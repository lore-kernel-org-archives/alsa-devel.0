From: "Botoaca Andrei" <warlock_ba@hotmail.com>
Subject: ISAPNP and alsa 0.9.3, 0.9.3a Bug
Date: Thu, 08 May 2003 15:49:13 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Law11-F85crYP0QzBxh00007232@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
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

I have installed RH9. The kernel is with everything it needs installed. 
ISAPNP ... everything.
In the config , i get PNP in kernel=no, but i have pnp in kernel (I checked 
flags , and everything is fine, and I got the same thing in the configure of 
0.9.2 too, but everything worked right).
I have a CMIPCI card (PCI) and an Yamaha Opl3-SaX (ISA). Until release 0.9.2 
everything worked fine for both.
The PCI card, works OK, but since 0.9.3, and 0.9.3a the ISA card won't 
start. I compiled the drivers with , and without ISAPNP suport. If I do 
without, I get unresolved symbols; if I do with, then it says that there are 
not enough resources, or the device is busy.
I checked. Resource for the card is free (exept IRQ 11) because my Yamaha 
has IDE controller on board, and I don't really care , and even if i remove 
the device which is using irq 11 , still not working. Same error. Other 
drivers are not loaded (neither alsa, nor oss). And I removed all other 
components except my videocard. And I still get the same error.
So I think there is a bug with that sound module, or if you have any ideea 
how to run configure so it works (because I saw many dummy files, that 
configure deletes, and if i don't put back the workqueue.h, no card works, 
unresolved symbol in workqueue ...).

Thanks a lot
Andrei Botoaca

_________________________________________________________________
STOP MORE SPAM with the new MSN 8 and get 2 months FREE* 
http://join.msn.com/?page=features/junkmail



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
