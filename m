From: "Pete Barnard" <petebarnard@tiscali.co.uk>
Subject: Re: [Alsa-user] Sound Card compatibility?
Date: Fri, 21 Mar 2003 22:12:28 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <007b01c2eff6$f721b590$0100a8c0@Pblaptop>
References: <5.2.0.9.1.20030322001740.00ab3e28@mail.ozemail.com.au>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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
To: Luke Yelavich <lukethemuso@ozemail.com.au>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


----- Original Message -----
From: "Luke Yelavich" <lukethemuso@ozemail.com.au>
To: "Pete Barnard" <petebarnard@tiscali.co.uk>
Sent: Friday, March 21, 2003 1:18 PM
Subject: Re: [Alsa-user] Sound Card compatibility?


> Hi
> That card will be fine, as it uses the snd-intel8x0 module. You shuldn't
> have any problems.
>
> Luke.

Thanks for your reply.  I have actualy been attempting to use it as a
snd-intel8x0 model today, as you and others said.  I have sucessfully
installed the drivers/libraries etc and loaded the modules.  But when I
brought up the alsamixer there were controls missing (notably the ADC and
DAC controls).  My ALSA sound capture program (which successfully works on
another machine using a cs46xx card) ran but only produced 0's and I was
unable to get any output by playing with alsamixer.  On my old machine
(cs46xx card) I simply set the ADC and Capture flag and lifted up some gains
but I cannot get alsamixer to make my program capture sound on the new
machine as there is no ADC control - which means I cannot set that flag.
Frustrating !

Here's a summary of what I have done so far.

[root@lucy root]# lspci
00:00.0 Host bridge: Intel Corp.: Unknown device 2560 (rev 01)
00:02.0 VGA compatible controller: Intel Corp.: Unknown device 2562 (rev 01)
00:1d.0 USB Controller: Intel Corp.: Unknown device 24c2 (rev 01)
00:1d.1 USB Controller: Intel Corp.: Unknown device 24c4 (rev 01)
00:1d.7 USB Controller: Intel Corp.: Unknown device 24cd (rev 01)
00:1e.0 PCI bridge: Intel Corp. 82801BA/CA PCI Bridge (rev 81)
00:1f.0 ISA bridge: Intel Corp.: Unknown device 24c0 (rev 01)
00:1f.1 IDE interface: Intel Corp.: Unknown device 24cb (rev 01)
00:1f.5 Multimedia audio controller: Intel Corp.: Unknown device 24c5 (rev
01)
05:08.0 Ethernet controller: Intel Corp.: Unknown device 103b (rev 81)

*********** /etc/module.conf **************
alias parport_lowlevel parport_pc
alias eth0 e100
alias usb-controller usb-uhci
alias usb-controller1 ehci-hcd
alias char-major-116 snd
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixers-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
alias snd-card-0 snd-card-intel8x0
post-install sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -L >/dev/null
2>&1 || :
pre-remove sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -S >/dev/null
2>&1 || :
alias char-major-89 i2c-dev
options it87 temp_type=0x31


*************************************************

from alsa-driversxxxx directory

./configure --with-cards=intel8x0 --with-sequencer=yes;
make;
make install;
./snddevices
(all seems to go through with no errors)

and then ./configure;make;make install for other alsa directories.

**********************************************

modprobe snd-intel8x0;
modprobe snd-pcm-oss;
modprobe snd-mixer-oss
modprobe snd
(all had no errors)


***************************************
alsamixer (comes up ok but no ADC or DAC controls).

My sound capture program runs but produces no output.

Any help appreciated.

Regards,

Pete



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
