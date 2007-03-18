From: Andrea Guzzo <xant@xant.net>
Subject: alsa userspace interface
Date: Sun, 18 Mar 2007 03:10:23 +0100
Message-ID: <3BC073ED-BC5A-48AB-A3D0-21F3A23B4DDB@xant.net>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
Cc: Stefan Richter <stefanr@s5r6.in-berlin.de>, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

some months ago I wrote an alsa driver for the Apple iSight audio unit.
I released it with the name "lisight' and it's available here:  
"http://lisight.sourceforge.net".
It's both an ieee1394 driver and an alsa one. It uses ieee1394  
framework to communicate
with the device and it registers an alsa device to make isight  
microphone available to the system.

Recently I was talking on the linux1394 mailing list about its  
submission to the mainline
kernel but  we are wondering if it's possible to register an alsa  
device from userspace.
Actually it would be a better approach to make an userspace driver  
when dealing with
removable devices like firewire or usb ones.
When I started writing the lisight kernel module , I tried to figure  
out if there were a way
to register an audio device from userspace...
I had the possibility to interact with the ieee1394 framework through  
libraw1394
(that uses raw1394 kernel module to access the firewire bus from  
userspace)
but I didn't found any documentation (nor references inside kernel  
sources) regarding an
alsa userspace interface to implement device drivers.
Is there any working or experimental one? ... If not, are you  
planning to export such an
interface to let developers make userspace drivers to deal with  
removable audio devices
without requiring applications to support jack or similar frameworks?

Thanks

Andrea Guzzo

ps.
Another interesting use of an hypothetical  alsa userspace interface  
for device drivers implementation would be
the possibility to implement virtual audio devices ....for example  
you could implement a
transparent sound server that doesn't require applications to support  
it explicitly and to link specific
libraries, but it would be simply accessed like any other alsa device  
and , with the use of substreams, it would allow
multiple applications to access audio facilities.... but this is  
another story :P 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
