From: "F. Heitkamp" <heitkamp-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>
Subject: Re: [LAU] [Alsa-user] [alsa-devel] Crash 2.6.32.x, Echo 3G, Alsa,
	SCSI
Date: Thu, 17 Jun 2010 08:11:06 -0400
Message-ID: <4C1A10DA.4080304@ameritech.net>
References: <73211.74714.qm@web180714.mail.sp1.yahoo.com>	<4B684513.8090201@ladisch.de>
	<20100202230911.71e8b600@Jay>	<4C040864.8010205@ameritech.net>
	<20100531225936.4a9344df@Jay>	<4C04FC3F.70905@ameritech.net>
	<20100603000828.04af4bdc@Jay>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
In-Reply-To: <20100603000828.04af4bdc@Jay>
List-Unsubscribe: <http://lists.linuxaudio.org/options/linux-audio-user>,
	<mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-user>
List-Post: <mailto:linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-user>,
	<mailto:linux-audio-user-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-user-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: Giuliano Pochini <pochini-JrPinEReyO8@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-audio-user-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org, Clemens Ladisch <clemens-P6GI/4k7KOmELgA04lAiVw@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: alsa-devel@alsa-project.org

  On 06/02/10 18:08, Giuliano Pochini wrote:
> On Tue, 01 Jun 2010 08:25:35 -0400
> "F. Heitkamp"<heitkamp-yWtbtysYrB+LZ21kGMrzwg@public.gmane.org>  wrote:
>
>>>> I've tried some newer kernels.  Still having problems with the echo 3G.
>>>> This is kernel version:
>>>> 2.6.32.13.  The above patches posted to the linux kernel list seemed to
>>>> get rid of the crashes, but evidently did not go into the main kernel tree.
>>>>
>>> Indeed. I've just checked 2.6.33 and the patch isn't there. It's in 2.6.34.
>>>
>>> If you need 2.6.32.13 you can apply the above patch to the kernel tree or
>>> download ftp://ftp.alsa-project.org/pub/driver/alsa-driver-1.0.23.tar.bz2,
>>> otherwise just use the latest kernel.
>>>
>> I tried 2.6.34.   I have jack 1.9..5 installed.  I was able to use
>> rhythmbox to play mp3s.  I could not use the echomixer app.  It complained
>> about a channels mismatch.
> I'm running 2.6.34 now. Both a very old version of echomixer (2005!) and
> the latest version I just compiled from alsa-tools-1.0.23 work fine with my
> Gina3G. Please quote the error message.
>
>
>> My goal is to be able to plug in a MIDI keyboard, or USB guitar
>> interface and play along with songs etc.
>>
>> I plugged in a MIDI keyboard, "/proc/asound/cards" showed the keyboard
>> was recognized.  The keyboard has a USB and MIDI interface.
>> I am not sure if they both work at the same time.  I had the MIDI cable
>> plugged into the Gina3G, but I could not tell if the keyboard was
>> recognized.
>> I compiled csound5.  When I engaged it the system immediately froze and
>> started spitting out:
>> [...]
> Ok, I compiled csound, but I don't know how to use it. How can I reproduce
> the problem ?
>
Sorry I took so long to get back to you.
It turns out Csound is not related to the problem.

In this case I am only using kernel 2.6.33.5-rt23-amd64, alsa lib 1.0.2, 
but 2.6.34 does it too.
I bring up firefox.  Web pages attempt to play sound.   The kernel 
begans doing:

[ 2879.766331] allocate_pipes: ch=1 int=2
[ 2879.766332] allocate_pipes: channel already open
[ 2879.766333] allocate_pipes(1) err=-11
[ 2879.766334] pcm_hw_freed
[ 2.821190] pcm_analog_out_open  cs=0  oc=2  r=44100
[ 2879.821266] allocate_pipes: ch=1 int=2
[ 2879.821267] allocate_pipes: channel already open

,infinitely.  The system is unusable at this point and I have to 
Alt-SysRq-k to get back in.

Let me know what other information to provide.

Here is hwinfo on the system:
cpu:
                        Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz, 
2400 MHz
                        Intel(R) Core(TM)2 CPU          6600  @ 2.40GHz, 
2400 MHz
keyboard:
   /dev/input/input0    EzKEY USB-compliant keyboard
printer:
                        HP deskjet 5600
graphics card:
                        PC Partner VGA compatible controller
sound:
                        PC Partner Audio device
storage:
                        LSI Logic / Symbios Logic 53c1030 PCI-X 
Fusion-MPT Dual Ultra320 SCSI
                        LSI Logic / Symbios Logic 53c1030 PCI-X 
Fusion-MPT Dual Ultra320 SCSI
                        Intel 82801G (ICH7 Family) IDE Controller
network:
   eth1                 Tyan 82573E Gigabit Ethernet Controller (Copper)
   eth0                 Tyan 82573E Gigabit Ethernet Controller (Copper)
network interface:
   eth1                 Ethernet network interface
   eth0                 Ethernet network interface
   lo                   Loopback network interface
usb controller:
                        Intel 82801G (ICH7 Family) USB2 EHCI Controller
                        Intel 82801G (ICH7 Family) USB UHCI #4
                        Intel 82801G (ICH7 Family) USB UHCI #3
                        Intel 82801G (ICH7 Family) USB UHCI #2
                        Intel 82801G (ICH7 Family) USB UHCI #1
bios:
                        BIOS
bridge:
                        Texas Instruments PCI bridge
                        Intel 6702PXH PCI Express-to-PCI Bridge A
                        Intel 82801GB/GR (ICH7 Family) LPC Interface Bridge
                        Intel 82801 PCI Bridge
                        Intel 82801GR/GH/GHM (ICH7 Family) PCI Express 
Port 6
                        Intel 82801GR/GH/GHM (ICH7 Family) PCI Express 
Port 5
                        Intel 82801G (ICH7 Family) PCI Express Port 1
                        Intel 975X Express PCI Express Root Port
                        Intel E7230 PCI Express Root Port
                        Intel E7230 Memory Controller Hub
hub:
                        ATEN International Hub
                        Linux 2.6.33.5-rt23-amd64 uhci_hcd UHCI Host 
Controller
                        Linux 2.6.33.5-rt23-amd64 uhci_hcd UHCI Host 
Controller
                        Linux 2.6.33.5-rt23-amd64 uhci_hcd UHCI Host 
Controller
                        Linux 2.6.33.5-rt23-amd64 uhci_hcd UHCI Host 
Controller
                        Linux 2.6.33.5-rt23-amd64 ehci_hcd EHCI Host 
Controller
memory:
                        Main Memory
firewire controller:
                        Timedia TSB82AA2 IEEE-1394b Link Layer Controller
unknown:
                        FPU
                        DMA controller
                        PIC
                        Timer
                        Keyboard controller
   /dev/lp0             Parallel controller
                        Echo Digital Audio 3G
                        Intel 82801G (ICH7 Family) SMBus Controller
                        PnP Unclassified device
                        PnP Unclassified device
                        PnP Unclassified device
                        Unclassified device
                        PnP Unclassified device
                        PnP Unclassified device
                        PnP Unclassified device
                        PnP Unclassified device
                        PnP Unclassified device
                        PnP Unclassified device
                        PnP Unclassified device
                        PnP Unclassified device
                        Serial controller
   /dev/input/input2    Logitech Trackball
   /dev/input/input1    EzKEY USB-compliant keyboard
                        Belkin UPS
