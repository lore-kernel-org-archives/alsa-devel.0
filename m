From: Uros Bizjak <uros@kss-loka.si>
Subject: Re: IRQ trouble...[notices]
Date: Mon, 27 Jan 2003 12:03:14 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E3511F2.9070206@kss-loka.si>
References: <3E32E87C.9000505@student.kuleuven.ac.be> <3E34D495.8050605@kss-loka.si> <3E34F410.5010400@student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E34F410.5010400@student.kuleuven.ac.be>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pieter Palmers wrote:

Other stuff:
--cut here--
//    bytes[0] = 0x04;
//    bytes[1] = 0x00;
//    err = snd_sam9407_init_command(sam, sam->system_io_queue,
            //           bytes, 2, buffer, 2, -1);

--comment--
-->  This is wrong syntax. There should be:
err = snd_sam9407_init_command(sam, sam->system_io_queue, bytes, 2, 
buffer, 1, 0x00)
where 0x00 is acknowledge, and only then you receive another 0x00 as 
message, as this could be some status or something.

All received messages are in form of ACK [message], where ACK is 
mandatory, and message is optional. Only when ACK > 0, driver will wait 
for interrupt to arrive. Following code should then be removed.
--comment--

    sam->writeCtrl(sam,0x04);
    sam->writeCtrl(sam,0x00);

    i=0;
    while (sam->readCtrl(sam) & (1<<7) && i<1000) {
      i++;
      udelay(100);
    }

    if (i>=999) {
          snd_printk("sam9407: timeout\n");
    }
    buffer[0]=sam->readData8(sam);

    i=0;
    while (sam->readCtrl(sam) & (1<<7) && i<1000) {
      i++;
      udelay(100);
    }
    if (i>=999) {
          snd_printk("sam9407: timeout\n");
    }
    buffer[1]=sam->readData8(sam);

    udelay(1000);
    snd_printk("sam9407: returns %02X %02X\n",buffer[0],buffer[1]);
/*    if (err)
        goto __error;




2191:    SAM Write to       CONTROL    value 0B
2194:    SAM Read  from     CONTROL    value 80
2197:    SAM Write to       CONTROL    value 00
2200:    SAM Read  from     CONTROL    value 80
2203:    SAM Write to       CONTROL    value 02
2206:    SAM Read  from     CONTROL    value 80
2209:    SAM Write to       CONTROL    value 00
2212:    SAM Read  from     CONTROL    value 80
2215:    SAM Write to       CONTROL    value 00
2218:    SAM Read  from     CONTROL    value 80
2221:    SAM Write to       CONTROL    value 57
2224:    SAM Read  from     CONTROL    value 80
2227:    SAM Write to       CONTROL    value 6B
2230:    SAM Read  from     CONTROL    value 80
2232:    SAM Read  from     CONTROL    value 00
2234:    SAM Read  from     DATA8    value 10        */

  You are loading microcode to address (fixed offset!!) 0x0200, page 
0x00, length 0x6b57 _words_ (equals 54958 bytes).
  It looks you should receive acknowledge with value 0x10, with no 
message. IMHO value 0x10 (ACK) should be delivered witn an interrupt?

  Hm... perhaps you need to clear interrupts (read data register) on 
maestro side?

  Maybe this is happening:

  - reset SAM9407 (sam generates spurious interrupt)
  - Maestro detects interrupt and raises IRQ flag and IRQ pin (or maybe 
it still has IRQ pending)
  - Nobody clears Maestro IRQ flag and its IRQs are stuck...
  - When SAM9407 raises its interrupt line, Maestro doesn't raise IRQ 
line (IRQ overrun), because its previous IRQ flag is not cleared

> The strange thing is that with the same driver code, I'm able to 
> generate both correct and incorrect operation:
> When using only the driver, ie modprobe snd-isis, then load the 
> bootcode through HWDEP, the HWDEP bootload fails. But when using the 
> maxiinit, ie modprobe snd-isis, run maxiinit in user space, then load 
> code through HWDEP, the HWDEP bootload succeeds. In the first case the 
> driver doesn't catch any interrupts, while in the second case it does 
> catch them.
> I must note that after running maxiinit, the card is already in the 
> operational state I want it to be. But I want to use the HWDEP 
> interface to get to this state, not the maxiinit app. 

  Do you have the same IRQ management (on whole IRQ chain 
(sam->maestro->[CPU]) regarding stuck IRQs?

> Uros: the sam9707 on the ISIS doesn't seem to send a checksum, is this 
> possible? I also had to modify your driver at some points where it 
> relied on card-specific details. I'll attach the code. 

  Yes, this can be specific to ews64 microcode. Looking at sam9407-1.0.0 
sources from Gerd, I see that this "feature" is unique to ews64.

> The most significant changes are:
> - Callbacks for any IO operation (instead of inw type calls) to 
> support the maestro way of transferring things. Those are verfied & 
> working

  Great - by using SAM ops we can abstract driver to "generic" one.

> - I don't know why, but I wrote my own main SAM module (snd-sam9407), 
> while you already provided sam9407_lib. But both are pretty much the 
> same. 

  Usually, toplevel modules are only those which describe cards. For 
example, you have mpu40_lib module, which can be used with toplevel 
mpu401 card or i.e. sb16 toplevel module. For example, my ews64 uses 
modules:
- ews64 (toplevel module)
-    sam9407_lib (this could be renamed to sam9x07_lib :)
-   some generic i2c stuff
-   ... etc

If I installed (i.e.) ISIS card which uses:
- meastro_lib
- sam 9x07_lib

  alongside ews64, then those two cards could share one generic module 
(sam9407_lib in our example). There is no card with only sam9407 chip 
onboard, but we would make toplevel sam9407 in case there is one, and it 
would use sam9407_lib.

> - replaced the bootcode
> - modified the userspace bootloader (too many assumptions, i.e. about 
> firmware size and start offset and so on.) 

  Yep, userspace loader is quick-hack-together temporary utility, which 
proved to be adequate for its job :) BTW: start offset is mandatory, 
otherwise you will write your microcode over boot code.

    Uros.



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
