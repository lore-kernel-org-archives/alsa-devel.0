From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: [PATCH] Tascam US-224/428 MMC Implementation
Date: Mon, 2 Aug 2004 16:43:09 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <33106.192.168.1.5.1091461389.squirrel@192.168.1.5>
References: <32814.192.168.1.8.1091390483.squirrel@192.168.1.8>      
    <32820.192.168.1.8.1091391304.squirrel@192.168.1.8>      
    <s5hy8kxsqks.wl@alsa2.suse.de>      
    <32825.192.168.1.5.1091448735.squirrel@192.168.1.5>      
    <s5hu0vlsorc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu0vlsorc.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Karsten Wiese <annabellesgarden@yahoo.de>, martin-langer@gmx.de, ws@seh.de
List-Id: alsa-devel@alsa-project.org

Hi Takashi, Karten, Martin,
everyone else,

>> BTW, I think this has been asked before but didn't had the chance to
>> know the right answer, so what's keeping snd-usb-usx2y out of the
>> stock 2.6 kernel.org tree?
>>
>> Anything to do with firmware licensing? IIRC there's already a GPL'd
>> bootstrap loader...
>
> No, just because I don't know whether the driver works on 2.6 kernel.
> No one reported/requested on alsa-devel ML yet.
>
> If it's confirmed to work, it's ok to push it up to 2.6 tree after
> some reviews/clean-up's.
>

OK. Now that you're asking, I've been testing on a couple of my boxes
and the results are a mix of success and a complete disappointment:

1) SUSE 9.1 Professional, vanilla 2.6.8-rc2 SMP/HT preemptible, NPTL 0.61:
   - hotplug/firmware load: OK.
     - snd-usb-usx2y 1.0.5a: OK, jackd RT: OK.
     - snd-usb-usx2y CVS HEAD 2004-08-01: OK, jackd RT: OK.

2) Mandrake 10.0 Official vanilla 2.6.8-rc2 UP preemptible, NPTL 0.60:
   - hotplug/firmware load: OK.
     - snd-usb-usx2y 1.0.5a: OK, jackd RT: unstable, non-RT seems OK.
     - snd-usb-usx2y CVS HEAD 2004-08-01: KO. HORROR!
       As soon as the pcm device is requested (e.g. via aplay)
       the whole system freezes, puff!
     This is a true showstopper as a matter of fact. FWIW it doesn't
     matter whether on NPTL or linuxthreads. In fact, I don't even know
     if this pthreads stuff has any influence at all. Certainly not.
     Please note that last patch of Karsten's probably did the
     difference, unfortunately for worse :/

FYI I'm on 2.6 since January, and I can certainly argue that on this
SUSE box everything is working flawlessly, period. Problem comes on that
Mdk box, don't know why. Is it due to SMP/HT? OTOH I don't even know if
all this thing works on 2.4 at all :) but I'm the only with a US-224 here,
am I?

Other US-x2y users may speak freely :)

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
