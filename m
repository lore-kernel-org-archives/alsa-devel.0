From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Oops? Linux 2.4.19 + snd-usb-audio (ALSA 0.9.0-rc5)
Date: Thu, 21 Nov 2002 17:25:44 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DDC7C68.4030901@superbug.demon.co.uk>
References: <64AE3D5B518E3648ACC823FBCB0B7375F550B0@sr002-2kexc.ateb.com>
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
To: Scott Parkerson <Scott.Parkerson@ateb.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Scott Parkerson wrote:

>Has anyone else seen a kernel panic when unplugging a busy (i.e.
>actively playing music) USB audio device using snd-usb-audio with Linux
>2.4.19 and ALSA 0.90-rc5? 
>
>I'll send my ksymoops output in a bit... Just wondering if this is just
>seen on my box. 
>
>
>Thanks,
>
>Scott Parkerson - Software Developer
>Ateb, Inc.
>919.872.1275
>www.ateb.com
>  
>
I think that will happen with most PCMCIA and USB devices in linux.
For my system, I have to specifically rmmod all the modules associated 
with the device before removing it.
I have written scripts to help me. E.g "eject-nic" that is for ejecting 
the Network interface PCMCIA card.
Also, "eject-camera" etc.
I think people will have to wait until kernel 2.5.x or above for better 
plug-n-unplug support.
Maybe I am wrong, and it is just a co-incidence that all the devices I 
have had bugs in the drivers.

Cheers
James






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
