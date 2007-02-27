From: =?ISO-8859-1?Q?Ingo_M=FCller?= <alsa@ingomueller.net>
Subject: Re: USB Audio Device: Philips Audio Set
Date: Tue, 27 Feb 2007 15:06:55 +0100
Message-ID: <45E43AFF.3080209@ingomueller.net>
References: <45E42E88.9080403@hubmer.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45E42E88.9080403@hubmer.at>
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

Hi!

I think that alsa-user would rather be the mailing list where this issue
should be discussed... Anyway, did you try

speaker-test -c2 -Dplughw:1,0 -twav

If this command produces white noise on your usb sound card, your
problem is only a matter of configuration.

Regards, Ingo



Andreas Hubmer schrieb:
> Hello,
> 
> I have a Philips mini hifi-system named "Philips FWM589" that can be
> used as an usb sound card. It is recognized as USB Audio device but I'm
> not able to get it to work.
> The module snd-usb-audio is loaded and in gnome a message pops up that a
> new audio device was found. In the gnome audio preferences a new device
> "USB Audio" is shown but the test sound doesn't work.
> 
> It seems that the "Philips Audio Set" is not standard-conform.
> Is there anyone who has experience with Philips USB sound cards or
> someone who can help me isolating the problem?
> Where should I start looking for possible problems?
> Is there a good way to debug the module snd-usb-audio? I found out that
> there exists the header file usbquirks.h. Can that be helpful to me?
> 
> Vendor/Product ID of the USB Device: 0471:0111
> 
> dmesg output after plugging in:
> [14603.564000] usb 1-2: new full speed USB device using uhci_hcd and
> address 7
> [14603.768000] usb 1-2: configuration #1 chosen from 1 choice
> [14603.776000] input: Philips Philips Audio Set as /class/input/input10
> [14603.776000] input: USB HID v1.00 Device [Philips Philips Audio Set]
> on usb-0000:00:1d.0-2
> [14604.176000] usbcore: registered new interface driver snd-usb-audio
> 
> cat /proc/asound/cars shows my onboard sound card and the USB device:
>  0 [ICH6           ]: ICH4 - Intel ICH6
>                       Intel ICH6 with AD1981B at 0xb0040800, irq 16
>  1 [Set            ]: USB-Audio - Philips Audio Set
>                       Philips Philips Audio Set at usb-0000:00:1d.0-2,
> full speed
> 
> To change the default alsa-device I also tried changing ~/.asoundrc and
> added the following lines:
> pcm.!default {
>         type hw
>         card Set
> }
> ctl.!default {
>         type hw
>         card Set
> }
> Afterwards I restarted alsa with "/etc/init.d/alsa-utils restart" but
> that didn't help. I couldn't hear anything.
> 
> I'm using Ubuntu 6.10 and the new kernel 2.6.20.1
> 
> Thanks for your help!
> 
> Andreas Hubmer
> 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
