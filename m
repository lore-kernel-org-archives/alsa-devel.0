From: Olivier Ricordeau <olivier.ricordeau@wanadoo.fr>
Subject: Re: [BUG] buggy ali5451 driver
Date: Mon, 04 Nov 2002 15:25:20 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DC68350.2040208@wanadoo.fr>
References: <m24raxpndj.fsf@vador.mandrakesoft.com> <s5hu1ixa0eu.wl@alsa2.suse.de>
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

Takashi Iwai wrote:
> At Mon, 04 Nov 2002 12:47:52 +0100,
> Thierry Vignaud wrote:
> 
>>regarding ali5451 problems that show up on kml, i just had access to
>>oliver's laptop which has the infamous ali5451.
>>
>>both oss' trident and alsa's snd-ali5451 cannot 
>>
>># modprobe snd-ali5451
>>PCI: Found IRQ 4 for device 00:08:0
>>URQ routing conflict for 00:08:0, have irq 5, want irq 4
>>
>>then kernel cries:
>>hda: status timeout: status=0x80 { Busy }
>>hda: DMA disabled
>>hda: drive not ready for command.
>>
>>disks cannot anymore be accessed. the system is still fine (no oops,
>>no freeze).
>>the vfs & ext3 then ended in I/O error since the disks answered
>>themselves busy to the eide controller.
> 
> 
> i know of similar problem with this.  they were much severe, caused
> kernel panic eventually.
> 
> 
>>the bugs ali5451 chips suffer may be related to :
>>
>>- either the poor ressources allocation on laptios, which is poorer &
>>  poorer since acpi "invade" laptops
> 
>  
> i suspect this.  can he disable acpi support?
> 

I can... if you explain me how to do this... A kernel option at boot 
time ?. Though I've used Linux for a few years, I'm quite a newbie 
regarding kernel stuffs.

> 
> Takashi
> 


-- 

  -= *Olivier RICORDEAU* =-   |  ICQ: 65452304
  Ing1 EPITA Millesime 2005   | Phone: 0686720852
           olivier.ricordeau@wanadoo.fr
          _Might the source be with you_



-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
