From: "Lisandro Pin" <lisandro@hotmail.com>
Subject: Possible snd-intel8x0 bug
Date: Tue, 20 May 2003 07:03:23 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <BAY2-F115cEcLsXJB7o0000e86c@hotmail.com>
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

  Hello. I have alsa running on a ECS K7S5A motherboard, which is listed to 
have a C-Media CMI9738 onboard audio chip, with a SIS chipset. It appears as 
  a "SiS SiS7012 PCI Audio Accelerator (rev 160)" on /proc/pci.

  The thing is, the snd-intel8x0 driver works great here... except for the 
PCM output volume. It can't be changed from either alsamixer or any OSS 
based mixer; it's on for every single position of the fader and off if it's 
set to zero. Any other mixer control works right. I've been trying to fix 
this myself for a while now (beleiving it was a dumb mistake of my part), 
but now i know of another person that has the same issue with that 
particular chip.

  Lys.

_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail



-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
