From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Lost dB volumes on USB headset between 2.6.38 and
 3.0
Date: Tue, 09 Aug 2011 13:19:37 +0200
Message-ID: <4E4117C9.2090100@colin.guthr.ie>
References: <4E410361.7010808@canonical.com> <4E410E7D.8050903@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from summit.brent.tribalogic.net (brent.tribalogic.net
	[78.86.109.144])
	by alsa0.perex.cz (Postfix) with ESMTP id 6515D103824
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Aug 2011 13:19:57 +0200 (CEST)
In-Reply-To: <4E410E7D.8050903@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

'Twas brillig, and Clemens Ladisch at 09/08/11 12:39 did gyre and gimble:
> David Henningsson wrote:
>> Hmm, I and Colin Guthrie have found a regression between kernels 2.6.38
>> and 3.0.
>>
>> When running "amixer -D hw:handset" for this device under 2.6.38, the
>> attached file is returned. Under 3.0, the dB information is missing.
>> This can't be intentional, can it?
> 
> There are patches that might have introduced bugs, but these two patches
> do remove dB information intentionally:
> 
> ALSA: usb-audio - Don't expose broken dB ranges:
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=59bb7f0eebe6
> ALSA: usb-audio - Add volume range check and warn if it too big:
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=80acefff3bc7
> 
> Are there any messages in the system log when loading the driver?
> What are the controls' dB ranges (see "amixer contents")?

Interesting thanks fpr the hints.

I get this when plugging in the device David mentioned previously.


usb 3-1: USB disconnect, device number 2
usbcore: deregistering interface driver snd-usb-audio
usb 2-1: new full speed USB device number 7 using uhci_hcd
usb 2-1: New USB device found, idVendor=1885, idProduct=0501
usb 2-1: New USB device strings: Mfr=2, Product=1, SerialNumber=0
usb 2-1: Product: BT Agile handset
usb 2-1: Manufacturer: Ascalade
input: Ascalade BT Agile handset as
/devices/pci0000:00/0000:00:1d.1/usb2/2-1/2-1:1.3/input/input14
generic-usb 0003:1885:0501.0006: input,hidraw0: USB HID v1.00 Device
[Ascalade BT Agile handset] on usb-0000:00:1d.1-1/input3
13:0: cannot get min/max values for control 2 (id 13)
14:0: cannot get min/max values for control 2 (id 14)
9:0: cannot get min/max values for control 2 (id 9)
10:0: cannot get min/max values for control 2 (id 10)
11:0: cannot get min/max values for control 2 (id 11)
9:0: cannot get min/max values for control 2 (id 9)
14:0: cannot get min/max values for control 2 (id 14)
11:0: cannot get min/max values for control 2 (id 11)
13:0: cannot get min/max values for control 2 (id 13)
10:0: cannot get min/max values for control 2 (id 10)
9:0: cannot get min/max values for control 2 (id 9)
usbcore: registered new interface driver snd-usb-audio


-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mageia Contributor [http://www.mageia.org/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
