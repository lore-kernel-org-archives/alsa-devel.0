From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Quattro MIDI (was: CVS changes, rc4 release in H-9)
Date: Wed, 23 Oct 2002 01:22:23 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DB57B3F.6050609@boosthardware.com>
References: <Pine.HPX.4.33n.0210221804560.12054-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com (www7.networkshosting.com [66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id SAA04320
	for <alsa-devel@alsa-project.org>; Tue, 22 Oct 2002 18:23:40 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Patrick Shirkey wrote:
> 
>>I'm now not able to use the qinit program to initialise the quattro
>>device anymore. A check of cat /proc/asound/card2/ yields only these
>>files now.
>>
>>id         midi0      oss_mixer
>>
>>i.e no stream info. I guess that nix noticed this last week on LAU but I
>>haven't updated for a couple of weeks so didn't catch when it happened.
> 
> 
> I added a quirk for the MIDI port. (BTW: Does it work?)
> It seems the USB subsystem only loads the first id_table entry it finds
> for each interface. As a quick fix, remove the Quattro entry from
> usbquirks.h, but I'm going to write a patch to use both pcm and MIDI.
> 

I would like to test it but I have no midi gear :)

I s'pose I could get the interface working but I haven't the time at the 
mo. There is another person who is trying I'll ask them how they are going.



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
