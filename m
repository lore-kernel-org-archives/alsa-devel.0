From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Quattro pcm devices
Date: Mon, 01 Jul 2002 21:53:24 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D2050C4.5020003@boosthardware.com>
References: <s5hbsa8h7fa.wl@alsa2.suse.de> <3D1E2685.1080704@boosthardware.com>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm seeing a problem with using JACK and this usb soundcard.

JACK works with this card on all pcm devices seperately but AFAICT is 
not able to access 2 pcm devices on this card at the same time.

This card has 3 stereo pcm devices.

hw:2,0 - capable of upto 16/44100

hw:2,1
hw:2,2 - capable of upto 24_3LE/96000

No matter what I try with .asoundrc I cannot get JACK to see 2 stereo 
i/o at one time. It hangs on startup.

I think it is because the devices 2,0 and 2,1 point to the same physical 
i/o channels and Jack is being blocked by ALSA from accessing them at 
the same time.

Is there anyway to change the order of the pcm devices so that

2,0 -> 2,2
2,1 -> 2,0
2,2 -> 2,1

If not is there anyway I can specify in the following that 
bindings.0.slave.a is hw:2,1 instead of hw:2,0?

----
pcm.quattro {
         type multi;

         slaves.a.pcm "hw:2,0";
         slaves.a.channels 3;


         bindings.0.slave a;
         bindings.0.channel 0;
         bindings.1.slave a;
         bindings.1.channel 1;
         bindings.2.slave a;
         bindings.2.channel 2;
	
}

ctl.quattro {
         type hw;
         card 0;
}

----

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
