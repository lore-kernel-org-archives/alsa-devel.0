From: Olivier Ricordeau <olivier.ricordeau@wanadoo.fr>
Subject: Re: [BUG] buggy ali5451 driver
Date: Mon, 04 Nov 2002 16:53:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DC69817.80300@wanadoo.fr>
References: <m24raxpndj.fsf@vador.mandrakesoft.com> <s5hu1ixa0eu.wl@alsa2.suse.de> <3DC68350.2040208@wanadoo.fr> <3DC68814.6070700@wanadoo.fr> <20021104112035.GA14883@dogsolitude.org> <3DC6903B.1070309@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Olivier Ricordeau wrote:
> drclaw@dogsolitude.org wrote:
> 
>> Try disabling "use dma by default" in the ide section.  If that then
>> fixes the problem I have a patch that can get you dma back.  I've got an
>> ali southbridge in my laptop as well and everything works fine. 
>> 784 - Michael C. Piantedosi - drclaw@dogsolitude.org
> 
> 
> OK...
> How can I disable dma in a shell??? Or do I need to recompile the kernel 
> or something?
> 

I've booted with the "nodma" option (I guess that what you wanted me to 
do), and now here is the new output for "modprobe ali5451":

"hda: status timeout: status=0x80 { Busy }
hda: drive not ready for command
ali mixer creating error.
Ali pci audio not found or device busy.
/lib/modules/2.4.19-18mdk/kernel/sound/pci/ali5451/snd-ali5451.o.gz: 
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, 
including invalid IO or IRQ parameters.
	You may find more information in syslog or on the output from dmesg
mosprobe: insmod 
/lib/modules/2.4.19-18mdk/kernel/sound/pci/ali5451/snd-ali5451.o.gz failed
modprobe: insmod snd-ali5451 failed"

After that, all my commands result in:
"hda: status timeout: status 8x80 { Busy }
hda: DMA disabled
hda: drive not ready for command"

I've also tried the same modprobe in single-user mode after a "hdparm 
-d0 /dev/hda", and no error message is displayed, but all my command 
result in the same error message as above.

-- 

  -= *Olivier RICORDEAU* =-   |  ICQ: 65452304
  Ing1 EPITA Millesime 2005   | Phone: 0686720852
           olivier.ricordeau@wanadoo.fr
          _Might the source be with you_



-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
