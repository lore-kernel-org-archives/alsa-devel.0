From: "Roger Andreassen" <randreas69@hotmail.com>
Subject: Troubleshoot soundcard positions
Date: Mon, 09 Aug 2004 18:29:29 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <BAY7-F14Orq8Dr4Guph000147fc@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I consider myself as a power newbie, but I have a delicate question I 
considered best asked here.

I have two Pinnacle PCTV Pro tuner cards and I've also the mobo cmipci 
loaded along with the Live! Player, Slackware 10.0 running kernel 2.6.7, 
Alsa 1-0.5 mandatory for running tweo tuners at once.

My object was to pull out the two patch cables as to achieve better sound. 
What the first 2.6.x kernel i tried (I think it was 2.6.3) then came the 
snd-bt87x driver.

At that time my two tuners became dsp0 and dsp1, Live Player as dsp2 and the 
C-Media sound as dsp3. What a nightmare. That means, to this day with 
Slackware 10.0 proper, all sound daemons and apps saw my "first" tuner as 
the primary sound card. No use really. ;)

Slackware loads Alsa with a /etc/rc.d/rc.alsa which can in fact be omitted, 
the drivers loads anyway (hotplug?). I've tried different modprobe.conf 
settings but the boot process goes out of its way to make sure my tuners get 
in my way.

For the time being I've hand-removed the snd-bt87x.ko module so KDE apps 
will run again. I can also run xmms at once without messing /dev up bc the 
Live! Player stays _dsp0_ this way.

I've also looked into "index=" entries but the system doesn't react no 
matter what I try.

Sorry to come down this way but I was unable to come up with anything on the 
mplayer list... maybe I'm being lazy but hey, I've built my PVR with cron 
entries. Not too bad. :-)


Regards,

Roger Andreassen,
Norway

_________________________________________________________________
MSN Hotmail  http://www.hotmail.com Med markedets beste SPAM-filter. Gratis!



-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
