From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: USB audio kernel panic
Date: Thu, 13 May 2004 10:09:01 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40A2CAAD.7050603@boosthardware.com>
References: <Pine.HPX.4.33n.0405111618000.8179-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Patrick Shirkey wrote:
> 
>>Using the latest usb-audio code from cvs I get a kernel panic when
>>loading the drivers.
>>
>>I'm running kernel-2.2.21 with gcc-2.95.4
> 
> 
> Works fine with my 2.2.19(?).
> 
> ALSA 1.0.4 fixed some horrible bugs in the USB compatibility code for
> 2.2.x kernels.
> 
> Where exactly does this crash happen?
> 

I just updated to the latest sf.net cvs. hdspmixer is working again but 
still get a kernel error with usb-audio.

This is the error message and the corresponding section of /proc/ksyms. 
(The actual symbol doesn't appear)

-----------

Unable to handle kernel paging request at virtual address 28302e63
  printing eip:
e08eafc0
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<e08eafc0>]    Tainted: PF



.
.
.

e08e7000 
__insmod_snd-usb-audio_O/lib/modules/2.4.21/kernel/sound/usb/snd-usb-au
dio.o_M40A2C2B5_V132117 [snd-usb-audio]
e08e7060 __insmod_snd-usb-audio_S.text_L29104   [snd-usb-audio]
e08eb02c snd_hack_usb_set_interface     [snd-usb-audio]
e08ed8a8 snd_usbmidi_disconnect [snd-usb-audio]
e08edff4 snd_usb_create_midi_interface  [snd-usb-audio]
e08ee220 __insmod_snd-usb-audio_S.rodata_L7690  [snd-usb-audio]
e08f01e0 __insmod_snd-usb-audio_S.data_L4548    [snd-usb-audio]
e08f13c0 __insmod_snd-usb-audio_S.bss_L64       [snd-usb-audio]
(END)


----------------
-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org/LAU/guide/ - The Linux Audio Users guide
Http://www.djcj.org/gigs/ - Gigs guide Korea
Http://www.nana7.net - Bar Nana - Itaewon, Seoul, Sth Corea
========================================


Apparently upon the beginning of the barrage, the donkey broke 
discipline and panicked, toppling the cart. At that point, the rockets 
disconnected from the timer, leaving them strewn around the street. 
Tethered to the now toppled cart, the donkey was unable to escape before 
the arrival of U.S. troops.

United Press International
Rockets on donkeys hit major Baghdad sites

By P. MITCHELL PROTHERO
Published 11/21/2003 11:13 AM



-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
