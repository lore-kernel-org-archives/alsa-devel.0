From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: [Alsa-devel] ALSA 1.0.0pre3 release
Date: Wed, 26 Nov 2003 17:38:04 +0100
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <3FC4D6EC.5070504@undata.org>
References: <s5h7k1oz2v0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <s5h7k1oz2v0.wl@alsa2.suse.de>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote :
> Hi,
> 
> right now the ALSA 1.0.0pre3 packages are released.
> 
> In this version, alsa-tools package was divided to two several ones,
> alsa-tools and alsa-firmware.  The latter contains only the firmware
> binary files required by loader programs in alsa-tools package.
> Please test them if you have a board requiring the loader (hdsp,
> mixart, vx, usx2y).
> 
> Especially, HDSP users, please test and report whether it works, since
> the hdsploader was modified to load the files dynamically.
> 
> 
> Changes
> 
> - usb-audio driver supports async unlinking.
>   On 2.6 kernels, it's enabled as default, but on older kenrels, it's
>   disabled to avoid a serious usb-uhci bug.  If you have another
>   controller, please try the module option async_unlink=1.
> 
> - hdsp driver update (including H9652 bugfixes).
> 
> - support of more Tascam USxxx devices.
> 
> - Audiotrak Prodigy bugfixes.
> 
> - fixed noise on vx222 with 24bit mode.
>    
> - complation fixes on alsa-drivers.
>   The 2.2 kernel is still not tested well.  If you can test it, please
>   let us know.
> 
> - fixed CM8738-MC6 5.1 alias.
> 
> - alsaconf fix for RH, Fedora and Mandrake.
> 
> - hdsp* tools updates.  compilation fixes.
> 
> 
> --
> Takashi Iwai <tiwai@suse.de>		ALSA Developer - www.alsa-project.org

Takashi it seems that at least for hdsploader (I didn't check the other 
tools) you forgot the trailing / in DATAPATH in Makefile.am, so the 
program fails to find the firmware file :
Unable to open file 
'/usr/local/share/alsa/firmware/hdsploadermultiface_firmware.bin' for 
reading

Thomas




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
