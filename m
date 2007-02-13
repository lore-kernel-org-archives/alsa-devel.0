From: Shingo HORISAWA <tora2329@yahoo.co.jp>
Subject: Re: Problems with Realtek HD Audio
Date: Tue, 13 Feb 2007 10:44:27 +0900 (JST)
Message-ID: <20070213014427.15549.qmail@web3209.mail.kcd.yahoo.co.jp>
References: <s5hodo3o7ea.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <s5hodo3o7ea.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi, Takashi.

> Hm, but if built properly with --with-debug=detect
> option, the driver
> must tells you a model name when you pass model=XXX
> option.  Make sure
> that the model option is really passed.  You can see
> the actual value
> in /sysfs/modules/snd_hda_intel/parameters/model
> file.

Sorry, I could find such descriptions on /var/log/messages

when ALSA was restarted.

When I didn't specify model, it says:

  kernel: PCI: Enabling device 0000:00:14.2 (0000 -> 0002)
  kernel: ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16
(level, low) -> IRQ 201
  kernel: ALSA
/usr/local/src/alsa/alsa-driver-hg20070210/pci/hda/../../alsa-kernel/pci/hda/hda_intel.c:696:
codec_mask = 0x1
  kernel: hda_codec: Unknown model for ALC262, trying
auto-probe from BIOS...
  kernel: ALSA
/usr/local/src/alsa/alsa-driver-hg20070210/pci/hda/hda_codec.c:2171:
autoconfig: line_outs=0 (0x0/0x0/0x0/0x0/0x0)
  kernel: ALSA
/usr/local/src/alsa/alsa-driver-hg20070210/pci/hda/hda_codec.c:2175:
   speaker_outs=1 (0x14/0x0/0x0/0x0/0x0)
  kernel: ALSA
/usr/local/src/alsa/alsa-driver-hg20070210/pci/hda/hda_codec.c:2179:
   hp_outs=1 (0x15/0x0/0x0/0x0/0x0)
  kernel: ALSA
/usr/local/src/alsa/alsa-driver-hg20070210/pci/hda/hda_codec.c:2187:
   inputs: mic=0x0, fmic=0x18, line=0x0, fline=0x0,
cd=0x0, aux=0x0

It says that "Unknown model for ALC262, trying auto-probe
from BIOS...".

And I could find the following messages 
when model is except "hp-bpc" and "hippo" on console.

   /usr/sbin/alsactl: set_control:970: failed to obtain
info for control #3 (No such file or directory)


> I still have no idea why wireshark interferes the
> sound stuff.  Maybe
> both are on the same IRQ line?  You can try
> enable_msi=1 option to
> snd-hda-intel to split the HD-Audio over MSI, just
> for testing.

I tried this option for all model, but it was the same
result...
And wireshark is only one of examples.
This problem also occurs on other applications, such as
konqueror, emacs, etc... 

> But, anyway, there are too little information from
> the sound driver
> itself.  Usually when something wrong occurs, the
> driver spits
> annoying warnings.  But in your case, it doesn't
> produce any errors.
> Puzzling...

I agree.
When capturing is stopped, there are no available
informations...



--------------------------------------
Start Yahoo! Auction now! Check out the cool campaign
http://pr.mail.yahoo.co.jp/auction/


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
