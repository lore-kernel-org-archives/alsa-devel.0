From: "Eliot Blennerhassett" <bigblen@icqmail.com>
Subject: Re: ./snddevices
Date: Thu, 19 Jun 2003 15:51:06 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030619155107.13707.h003.c012.wm@mail.icqmail.com.criticalpath.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: pshirkey@boosthardware.com
List-Id: alsa-devel@alsa-project.org

> plugin "alsa". Trying defaults. snd_pcm_open: Permission denied (quattro1)
> Failed to initialize plugin! -----

I had similar problems. Sometimes i could access ALSA devices as a normal user,
and sometimes only as root. It seemed to change (for the worse)if I unloaded all
the sound modules and then reloaded.

I went and chmod ug+rw /dev/snd/*, but this didn't always work
(Hmmm maybe after I had to press the reset button...)

Removing /lib/dev-state/snd at the same time as doing the chmod seemed to do the
trick...

I also had to add myself to the 'audio' group (or is that add "audio" to my
groups list)

Eliot Blennerhassett
AudioScience Inc.
--
Junk footer beyond this point. Read at your own risk.


-------------------------------------------------------------
Sign up for ICQmail at http://www.icq.com/icqmail/signup.html


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
