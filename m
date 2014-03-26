From: <baumber@hotmail.com>
Subject: Re: Fwd: Re: no reset_resume for driver snd-usb-audio
 for logitech headset H600
Date: Wed, 26 Mar 2014 18:09:37 +0100
Message-ID: <BLU0-SMTP3798BADA0E8CD057CBF8403A1640@phx.gbl>
References: <527FA9B6.3000403@hotmail.com>	<BLU0-SMTP389A28B3B37C63ADEE0EE1AA1B20@phx.gbl>	<s5h61pow6hk.wl%tiwai@suse.de>	<BLU0-SMTP103D5034514D3C096609C3AA1BA0@phx.gbl>	<s5hiotfoxbt.wl%tiwai@suse.de>	<s5ha9eqab6s.wl%tiwai@suse.de>	<BLU0-SMTP858B91706D3BD97C1E57FBA1A70@phx.gbl>	<s5hfvogj5t3.wl%tiwai@suse.de>	<BLU0-SMTP475521F4286A027768D8AB0A1650@phx.gbl>
 <s5hsiq5a25t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from blu0-omc3-s3.blu0.hotmail.com (blu0-omc3-s3.blu0.hotmail.com
 [65.55.116.78]) by alsa0.perex.cz (Postfix) with ESMTP id CF591264F74
 for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2014 18:09:42 +0100 (CET)
In-Reply-To: <s5hsiq5a25t.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>, alsa-devel@alsa-project.org, USB list <linux-usb@vger.kernel.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 2014-03-26 07:45 CET (UTC+1), Takashi Iwai wrote:

>> Thank you for your patch, it is working fine.
>>
>> It works with hibernate, the mixer value stays and the master channel "headset" (kmix) is selected after hibernate as it should be.
>>
>> When will the patch be in mainline => 3.14? and backported to LTS-kernels?
>
> It'll be in 3.15 kernel.  No stable backport is planned, though.

Thank you.

Another issue/problem with the headset occurs every ~10th - 20th hibernate cycle, but is not related to your patch.
The usb-headset (the usb transceiver part) disconnects and reconnects immediately after resume.
This behaviour was also before your patch and I interpreted this as device reset and as a problem of the device itself.
Because of this behaviour the master channel "headset" in kmix is also cleared and reset to the onboard one.

Do you know if this is a kernel bug or a device bug?

Bernhard

usb-headset disconnects/reconnects after resume;
------------------------------------
[ 3901.627484] ata6.00: configured for UDMA/133
[ 3901.630579] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[ 3901.630593] sd 7:0:0:0: [sdc] Starting disk
[ 3901.634755] ata5.00: configured for UDMA/133
[ 3901.646699] sd 5:0:0:0: [sdb] Starting disk
[ 3901.654656] sd 4:0:0:0: [sda] Starting disk
[ 3901.666459] firewire_core 0000:0c:03.0: rediscovered device fw0
[ 3901.670491] usb 2-1: reset high-speed USB device number 2 using ehci-pci
[ 3901.874780] usb 1-1.4: reset high-speed USB device number 3 using ehci-pci
[ 3902.271236] usb 2-1.2: reset low-speed USB device number 3 using ehci-pci
[ 3902.623801] usb 1-1.4.3: reset high-speed USB device number 4 using ehci-pci
[ 3902.996413] usb 1-1.4.3.4: reset full-speed USB device number 6 using ehci-pci
[ 3903.160598] usb 1-1.4.3.3: reset full-speed USB device number 5 using ehci-pci
[ 3903.329030] PM: restore of devices complete after 2234.676 msecs
[ 3903.329283] PM: Image restored successfully.
[ 3903.329284] Restarting tasks ... done.
[ 3903.336466] PM: Basic memory bitmaps freed
[ 3904.575113] r8169 0000:05:00.0 eth0: link down
[ 3904.575127] r8169 0000:05:00.0 eth0: link down
[ 3904.575153] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[ 3906.277519] r8169 0000:05:00.0 eth0: link up
[ 3906.277531] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[ 3958.031248] usb 1-1.4.3.3: USB disconnect, device number 5
[ 3958.743798] usb 1-1.4.3.3: new full-speed USB device number 7 using ehci-pci
[ 3959.165798] usb 1-1.4.3.3: New USB device found, idVendor=046d, idProduct=0a29
[ 3959.165806] usb 1-1.4.3.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 3959.165810] usb 1-1.4.3.3: Product: Logitech Wireless Headset
[ 3959.165813] usb 1-1.4.3.3: Manufacturer: Logitech
[ 3959.165817] usb 1-1.4.3.3: SerialNumber: 000d44b20870
[ 3959.249740] input: Logitech Logitech Wireless Headset as /devices/pci0000:00/0000:00:1a.0/usb1/1-1/1-1.4/1-1.4.3/1-1.4.3.3/1-1.4.3.3:1.3/input/input17
[ 3959.250347] hid-generic 0003:046D:0A29.0007: input,hiddev0,hidraw1: USB HID v1.11 Device [Logitech Logitech Wireless Headset] on usb-0000:00:1a.0-1.4.3.3/input3
[ 3959.539837] hda-codec: out of range cmd 2:5:707:ffffffbf
