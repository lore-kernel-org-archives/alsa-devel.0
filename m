From: Christoph Lameter <christoph@lameter.com>
Subject: Re: cmipci driver locking up linux hard
Date: Mon, 7 Aug 2006 13:03:16 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0608071302330.7264@graphe.net>
References: <Pine.LNX.4.64.0608041616590.9917@graphe.net>
	<s5hy7u0raux.wl%tiwai@suse.de>
	<Pine.LNX.4.64.0608070927480.3308@graphe.net>
	<s5hhd0os9nv.wl%tiwai@suse.de>
	<Pine.LNX.4.64.0608071252380.7100@graphe.net>
	<s5hu04oqpwy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hu04oqpwy.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 7 Aug 2006, Takashi Iwai wrote:

> > Will lockup if I play an mp3.
> 
> Hm, it sounds really odd. 
> 
> I'm afraid that the problem might lie rahter on the VIA controller
> side.  Which devices are sharing the same irq line?

pentium940:/usr/src/linux-2.6# cat /proc/interrupts
           CPU0       CPU1
  0:     757651     740334    IO-APIC-edge  timer
  1:         10          3    IO-APIC-edge  i8042
  9:          0          0   IO-APIC-level  acpi
 14:       4974       3633    IO-APIC-edge  ide0
 15:       6542       6659    IO-APIC-edge  ide1
185:       4494          0   IO-APIC-level  eth0
201:       2291       2450   IO-APIC-level  uhci_hcd:usb1, uhci_hcd:usb2, 
uhci_h cd:usb3, uhci_hcd:usb4, ehci_hcd:usb5
209:         45        122   IO-APIC-level  CMI8738-MC6
NMI:    1497891    1497799
LOC:    1497738    1497765



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
