From: Andrei Boros <andrei@srr.ro>
Subject: snd-opti92x-ad1848 problems
Date: Thu, 20 Mar 2003 10:52:18 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E798142.B875E784@srr.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


 I finally got the modules to compile and work. make-3.79 gave me a
headache to install last night, but I got it in. 

 I built the snd-opti92x-ad848 module and attempted to use it:

isapnp configures the card as : 
gate:/lib/modules/2.2.24/misc# isapnp /etc/isapnp.conf
Board 1 has Identity 1f 08 00 00 00 24 09 14 3e:  OPT0924 Serial No
134217728 [checksum 1f]
OPT0924/134217728[0]{Pro Audio 16        }: Ports 0x220 0x130 0x380;
IRQ7 DMA0 DMA1 --- Enabled OK
OPT0924/134217728[1]{Game Port           }: Port 0x201; --- Enabled OK
OPT0924/134217728[2]{MPU401              }: Port 0x300; IRQ5 --- Enabled
OK
/etc/isapnp.conf:263 -- Warning - resource conflict allocating IRQ5 (see
/etc/isapnp.conf)
OPT0924/134217728[5]{OPT924              }: Port 0x30D; IRQ5 --- Enabled
OK

(with or without MPU401 enabled and that shared IRQ is the same. anyway,
I got no more spare irqs...)

a modprobe snd-opti92x-ad1848 gives Device or resource busy.
I tried to give it the parameters as isapnp=1, same.
I gave it all the parameters with all settings as set by isapnp tool,
same.
Then, on a hunch, I gave changed the port from 220 to 530 (as I
remembered this was the port it used to run on under windows as WSS)

I did: 
 modprobe snd-opti92x-ad1848 isapnp=1 port=0x220 mpu_port=0x300
fm_port=0x380 irq=7 mpu_irq=5 dma1=0

and the module loaded ok! 

I tried to play some sound file and I get :
# aplay daffy12.wav
Playing WAVE 'daffy12.wav' : Unsigned 8 bit, Rate 11025 Hz, Mono
aplay: pcm_write:1025: write error: Input/output error



-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This SF.net email is sponsored by: Tablet PC.  
Does your code think in ink? You could win a Tablet PC. 
Get a free Tablet PC hat just for playing. What are you waiting for? 
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
