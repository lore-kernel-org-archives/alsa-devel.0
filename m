From: Manuel Jander <mjander@embedded.cl>
Subject: Aureal VOrtex update and MPU401 survey
Date: Thu, 13 Mar 2003 00:28:39 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E7008F7.1090207@embedded.cl>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi everyone.

Aurela Vortex:
I'm pleased to announce that the Vortex driver PCM is working.
Its not 100% perfect yet, sometimes it skips, but that will be done
in the next week (i'll try to add Scatter Gather support).

MPU401 survey:
I though about a modification for the mpu401_uart driver, to allow
a more versatil handling of different IO types. I observed that
at least the SBLive, appart from the Vortex have a standart MPU401 port, 
but the hardware IO is slighdely different enough to prevent the usage 
of the existing MPU401 driver. That means the driver is copy pasted and 
only the Register access (inb and outb) calls are modified.

Know there are too options: allow replacement functions for inb and 
outb, or to use wrappers that accept the mpu type as parameter so that a 
more sophisticated IO handling can be done. THat means:

case 1

typedef mpu401_t {
   ....
   void (*write) (u8 data, u32 addr);
   u8 (*write) (u32 addr);
   ....
}
.....

mpu->write = outb;
mpu->read = inb;


----------- < OR >-------------------
case 2

typedef mpu401_t {
   ....
   void (*write) (mpu401_t *mpu, u8 data, u32 addr);
   u8 (*write) (mpu401_t *mpu, u32 addr);
   ....
}

...

mpu->write = mpu_write;
mpu->read = mpu_read;


... and implemented in the specific card driver:

void mpu_write(mpu401_t *mpu, u8 data, u32 addr) {
     some_iohardware_write(mpu->private_data, data, addr);
}

void mpu_write(mpu401_t *mpu, u8 data, u32 addr) {
     return some_iohardware_read(mpu->private_data, addr);
}


The question is: Can anyone take advantage of having the "mpu" object 
avaiable inside a IO wrapper ? The SBLive should, but are the 
maintainers of the SBLive in the mood to actually make use of that ?

-If the mpu401_uart driver assigns per default the apropiate functions 
to mpu->write and mpu->read, -no change in the API is needed-.
-At least case 1 is needed to avoid having to copy paste the driver for 
the Aureal Vortex since it uses mmio instead of port io.

Best Regards

Manuel Jander.




-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
