From: "Svetoslav Slavtchev" <svetljo@gmx.de>
Subject: Re: Problems with Gamesurround Muse Pocket USB	&	2.6.0-test11
Date: Mon, 8 Dec 2003 14:10:26 +0100 (MET)
Sender: linux-usb-devel-admin@lists.sourceforge.net
Message-ID: <31110.1070889026@www27.gmx.net>
References: <1070885659.1676.385.camel@kronenbourg.scs.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: linux-usb-devel@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Thanks.
> 
> >         bNrChannels             6
> 
> Hm, the OSS driver doesn't really support more than 2 channels, as the
> OSS API is more or less stereo only.

ok, but it has two interfaces - 2ch & 6ch, or am i wrong
and it's supposed to work on Mac(without driver) 
as a stereo device(written on the box)

currently :
1. with oss driver
  i'm getting stereo sound on the front chanels, but i can not controll it
at all,
 headphones  are almost working - i can control the level from a mixer, but
not from 
 program (e.g.  mplayer, xmms)
---------------------------------
[root@svetljo root]# aumix -d /dev/mixer1 -q
vol 18, 18  // this one controls the headphones
line 83, 83  // no effect
mic 74, 74
[root@svetljo root]# aumix -d /dev/mixer2 -q
line 0, 0, P // no effect
mic 0, 0, R
--------------------------------
2. with alsa 
if i unload the oss driver, and load snd-usb-audio
only a mixer device is registered, no dsp devices
nothing is working

> ALSA should be better suited for this, but I don't know too much about
> their USB driver...

well i'm still waiting my messages to hit alsa-devel,
let's see what will happen, but shouldn't it work 
with the oss driver at least in stereo mode

thanks for your help

svetljo

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
