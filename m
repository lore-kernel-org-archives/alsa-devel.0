From: Fredrik Lingvall <fl@signal.uu.se>
Subject: Zoomed Video on Maestro 2E
Date: Fri, 15 Mar 2002 20:36:48 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3C924D50.2050902@signal.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Received: from signal.uu.se (IDENT:3izOpZ7rnnEnO4As2OGkygduyGdQFdYm@signserv.Signal.Uu.Se [130.238.47.210])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA22073
	for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2002 20:46:02 +0100
Received: from signal.uu.se (fllap.signal.uu.se [192.168.200.29])
	by signal.uu.se (8.11.6/8.11.6) with ESMTP id g2FJjsc18276
	for <alsa-devel@alsa-project.org>; Fri, 15 Mar 2002 20:45:55 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  Hi!

I'm trying to switch on ZV audio on a Maestro 2E chip. According to the
Maestro data sheet it is  Bit 15  in ESM_RING_BUS_CONTR_A
register (=0x36) that controls the I2S input which contain the ZV data 
(I think).
However, I had no luck so far, I can see the ZV video (in xawtv) but
there is no audio. I added a module option for ZV to  the
snd-card-es1968module and added this code to the  snd_es1968_probe(...)
function in card-es1968.c:


    /* Switch on ZV if module option snd_es1968_zvport = 1
       Should really put this stuff in a funtion. Even better -
       add a setting in the mixer for switching on ZV.
    */
   
    if (snd_es1968_zvport[dev] != 0) {
      u16 reg;
   
      reg = inw(chip->io_port + 0x36);
      snd_printk("Switching on ZV audio (Ring Bus Control Reg, before = 
%x",reg);
      reg |= 0x8000; /* Set bit 15 = I2S on, which should switch on ZV 
audio ?!*/
      outw(reg, chip->io_port + 0x36);
      reg = inw(chip->io_port + 0x36);
      printk(", after = %x\n",reg);
    }


Are there any other registers controlling the ZV input?

I'm using a Margi DVD to-go mpeg card as ZV source and
the laptop is equipped with a ATI  3D Rage LT Pro graphics
chip. Drivers can be found at www.linuxtv.org and GATOS.

Fredrik


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
