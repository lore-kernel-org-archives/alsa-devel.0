From: "Roger Villars" <roger.villars@fhso.ch>
Subject: Userspace ALSA Soundcard
Date: Thu, 14 Oct 2004 09:32:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <MEMPHIS1yhB9GYV22CH00000003@Memphis.stud.so.fhnw.ch>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
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


Hello

I'm new to the ALSA Framework and I'm trying to program
a "virtual" soundcard for a Bluetooth Headset that is running
completely in userspace. No kernel modules or something.

You should only start a deamon program and then every ALSA beware
program can "see" a new Soundcard.

First Question: Do you think this is possible?

Second Question: How?

I heard that there is a file called pcm_jack.c in ALSA that is
doing exactly what I need. But as I'm new to ALSA I don't know
how and where in the code it is doing it.

Would be nice if somebody can give me some Know-how. 

Thanks

P.S. Sorry for the bad English, I'm an alien ;-) 




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
