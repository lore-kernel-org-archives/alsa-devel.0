From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: CVS changes, rc4 release in H-9
Date: Wed, 23 Oct 2002 00:19:52 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DB56C98.7040205@boosthardware.com>
References: <s5hsmyy3gv4.wl@alsa2.suse.de>	<Pine.LNX.4.33.0210221245470.521-100000@pnote.perex-int.cz>	<s5hlm4q3fpr.wl@alsa2.suse.de>	<3DB565AB.3080304@boosthardware.com> <s5hfzuy34l0.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id RAA03512
	for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2002 17:21:48 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 22 Oct 2002 23:50:19 +0900,
> Patrick Shirkey wrote:
> 
>>I'm updating the site docs now. what should I do with the usb midi doc? 
>>Just link it into the usb-audio page or merge them together completely?
> 
> 
> the usb-midi was completely merged with usb-audio.
> that is, there is no longer an extra module for midi.
> just use snd-usb-audio for all usb devices.
> 

OK

I'm now not able to use the qinit program to initialise the quattro 
device anymore. A check of cat /proc/asound/card2/ yields only these 
files now.

id         midi0      oss_mixer

i.e no stream info. I guess that nix noticed this last week on LAU but I 
haven't updated for a couple of weeks so didn't catch when it happened.
-------

ALSA lib pcm_hw.c:866:(snd_pcm_hw_open) open /dev/snd/pcmC2D1p failed: 
No such file or directory

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 1024 (LWP 15806)]
0x400599a5 in snd_pcm_hw_refine (pcm=0x40000000, params=0xbffff760)
     at pcm_params.c:2144
2144            res = pcm->ops->hw_refine(pcm->op_arg, params);

------------

-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net emial is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4699841;7576301;v?http://www.sun.com/javavote
