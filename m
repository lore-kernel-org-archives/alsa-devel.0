From: Raymond <rayau@netvigator.com>
Subject: Re: Re: aplay - How to use device 3 of card 0 ?
Date: Tue, 08 Mar 2005 19:58:21 +0800
Message-ID: <422D935D.9020109@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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

 >> # aplay --verbose -d hw:0,3 piano.wav
 >> Playing WAVE 'piano.wav' : Signed 16 bit Little Endian, Rate 44100 
Hz, Mono
 >> Plug PCM: Hardware PCM card 0 'au8830' device 0 subdevice 0
   ^^^^^^^^^
 > It's already wrong.  Instead of hw:0,3, plug layer is used.

 > Do you have any definition in ~/.asoundrc or /etc/asound.state?
 > Is /usr/share/alsa/alsa.conf is properly updated from the latest
 > alsa-lib, too?

http://sourceforge.net/mailarchive/forum.php?thread_id=6750837&forum_id=33141

latest CVS version cannot compile on kernel 2.4

#./cvscompile --with-cards=au8830 --with-sequencer=yes
...
make  -C mpu401 modules
make[2]: Entering directory `/root/alsa/cvs/alsa-driver/drivers/mpu401'
gcc -D__KERNEL__ -DMODULE=1 -I/root/alsa/cvs/alsa-driver/include
-I/lib/modules/2.4.22-1.2199.nptl/build/include -O2
-mpreferred-stack-boundary=2 -march=i686 -DLINUX -Wall
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc
-iwithprefix include   -DEXPORT_SYMTAB -c mpu401_uart.c
In file included from mpu401_uart.c:1:
../../alsa-kernel/drivers/mpu401/mpu401_uart.c: In function
`snd_mpu401_uart_input_trigger':
../../alsa-kernel/drivers/mpu401/mpu401_uart.c:313: warning: implicit
declaration of function `spin_trylock_irqsave'
In file included from mpu401_uart.c:1:
../../alsa-kernel/drivers/mpu401/mpu401_uart.c:298: warning: `flags'
might be used uninitialized in this function
rm -f snd-mpu401-uart.o
ld  -r -o snd-mpu401-uart.o mpu401_uart.o
make[2]: Leaving directory `/root/alsa/cvs/alsa-driver/drivers/mpu401'
...

#make install
..
/sbin/depmod -a 2.4.22-1.2199.nptl
depmod: *** Unresolved symbols in
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/drivers/mpu401/snd-mpu401-uart.o
...

#/etc/init.d/alsasound start
Starting sound driver: snd-au8830
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/drivers/mpu401/snd-mpu401-uart.o: 

unresolved symbol spin_trylock_irqsave
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/drivers/mpu401/snd-mpu401-uart.o: 

insmod
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/drivers/mpu401/snd-mpu401-uart.o 

failed
/lib/modules/2.4.22-1.2199.nptl/kernel/sound/drivers/mpu401/snd-mpu401-uart.o: 

insmod snd-au8830 failed
done






-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
