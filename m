From: Matthias Koenig <mk@phasorlab.de>
Subject: Re: Re: [PATCH] alsa-driver: Support for ESI Miditerminal 4140 (#3)
Date: Tue, 02 May 2006 16:25:00 +0200
Message-ID: <87fyjs4i83.fsf@zebra.localdomain>
References: <87r73c4ryj.fsf@zebra.localdomain> <s5haca0zlxw.wl%tiwai@suse.de>
	<87k6944l0j.fsf@zebra.localdomain> <s5h7j54o7jw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7j54o7jw.wl%tiwai@suse.de> (Takashi Iwai's message of "Tue,
	02 May 2006 15:55:15 +0200")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:
>
> Last but not least:  spin_lock(mts->lock) ==> spin_lock(&mts->lock)

Oh, this is really wrong at all places from the beginning and strangely 
enough I didn't get any compilation error.

> Don't worry, I'll fix them by myself before committing the patch :)

Takashi, thank you very much for review and help!

Matthias


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
