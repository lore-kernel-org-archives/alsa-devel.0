From: frankgaetano@collegeclub.com
Subject: Hammerfall DSP System Problems
Date: Thu, 5 Jun 2003 17:28:02 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <7954491.1054848482159.JavaMail.java@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_38_3254696.1054848482148"
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

------=_Part_38_3254696.1054848482148
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello, 
  I recently purchased a Hammerfall DSP system to use on Windows and 
especially LINUX for use on Ardour. I have the multiface system. I 
must say I am confused on the support of the newest version of this 
pci card (I know that I have firmware version 11). I downloaded the 
current CVS on alsa-dev and compiled it fine. However when I run 
modprobe I get the following error: 
 
 /sbin/modprobe snd-hdsp 
/lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o: 
init_module: No such device 
Hint: insmod errors can be caused by incorrect module parameters, 
including invalid IO or IRQ parameters 
/lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o: insmod 
/lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o failed 
/lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o: insmod 
snd-hdsp failed 
 
Then when I just offer the command insmod snd-hdsp I get the 
following: 
 
/sbin/insmod snd-hdsp 
Using /lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o 
/lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o: unresolved 
symbol snd_hammerfall_get_buffer_R5bab1fdf 
/lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o: unresolved 
symbol snd_rawmidi_receive_R1e37534c 
/lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o: unresolved 
symbol snd_rawmidi_transmit_Rf1a57f87 
/lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o: unresolved 
symbol snd_hwdep_new_Rcd2873ef 
/lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o: unresolved 
symbol snd_rawmidi_new_R0bc1cb4d 
/lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o: unresolved 
symbol snd_rawmidi_set_ops_Rc12d8ec9 
/lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o: unresolved 
symbol snd_rawmidi_transmit_empty_R1a8b7b46 
/lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o: unresolved 
symbol snd_hammerfall_free_buffer_R4d176ca0 
 
/var/log/messages gives me the following: 
 
Jun  5 17:17:00 musicman kernel: Hammerfall memory allocator: buffers 
allocated 
for 1 cards 
Jun  5 17:17:00 musicman kernel: RME Hammerfall-DSP: no cards found 
Jun  5 17:30:40 musicman kernel: Hammerfall memory allocator: buffers 
allocated 
for 1 cards 
Jun  5 17:30:40 musicman kernel: RME Hammerfall-DSP: no cards found 
Jun  5 17:30:40 musicman insmod: 
/lib/modules/2.4.18-3/kernel/sound/pci/rme9652/ 
snd-hdsp.o: init_module: No such device 
Jun  5 17:30:40 musicman insmod: Hint: insmod errors can be caused by 
incorrect 
module parameters, including invalid IO or IRQ parameters 
Jun  5 17:30:40 musicman insmod: 
/lib/modules/2.4.18-3/kernel/sound/pci/rme9652/ 
snd-hdsp.o: insmod snd-card-0 failed 
Jun  5 17:30:40 musicman kernel: Hammerfall memory allocator: buffers 
allocated 
for 1 cards 
Jun  5 17:30:40 musicman kernel: RME Hammerfall-DSP: no cards found 
Jun  5 17:30:40 musicman insmod: 
/lib/modules/2.4.18-3/kernel/sound/pci/rme9652/ 
snd-hdsp.o: init_module: No such device 
Jun  5 17:30:40 musicman insmod: Hint: insmod errors can be caused by 
incorrect 
module parameters, including invalid IO or IRQ parameters 
Jun  5 17:30:40 musicman insmod: 
/lib/modules/2.4.18-3/kernel/sound/pci/rme9652/ 
snd-hdsp.o: insmod snd-card-0 failed 
 
When I run hdsploader it completes but says nothing like this: 
 
hdsploader - firmware loader for RME Hammerfall DSP cards 
Looking for HDSP + Multiface or Digiface cards : 
 
 
I have the multiface connected while I run it.  I am really confused 
with this card and driver. I am new to alsa but not to Linux. I would 
really like to run this card. Any help will be great. However, if this 
situation has been resolved I am sorry. I just need to be pointed in 
the right direction. 
 
Thanks, 
Frank Emanuele 
 
 
 
 



-------------------------------------------------------------------------- 
Looking for a roommate? Let CollegeClub.com help you out!
<http://navisite.collegeclub.com/channels/college/>

CollegeClub.com makes college life even better.
------=_Part_38_3254696.1054848482148--



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
