From: Matthias Saou <matthias@rpmforge.net>
Subject: Re: [Alsa-user] alsa cvs, redhat9, kernel 2-4-20-8
Date: Mon, 7 Apr 2003 12:27:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030407122753.104effb3.matthias@rpmforge.net>
References: <se8e13a5.075@mail.teklinks.com>
	<20030405120028.6812ba7e.matthias@rpmforge.net>
	<s5hznn2r4n9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznn2r4n9.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: jsanders@teklinks.com, jason@corekin.no-ip.com
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> wrote :

> the current alsa code checks the existence of __WORK_INITIALIZER
> macro.  if it's defined, no wrapper function is used.
> in rh's include/linux/workqueue.h, is this macro defined?

Yes, it is... from /usr/src/linux-2.4.20-x/include/linux/workqueue.h:

#define __WORK_INITIALIZER(n, f, d) {                           \
        .entry  = { &(n).entry, &(n).entry },                   \
        .func = (f),                                            \
        .data = (d) }

Matthias

-- 
Clean custom Red Hat Linux rpm packages : http://freshrpms.net/
Red Hat Linux release 8.0.9x (Phoebe) running Linux kernel 2.4.20-2.54
Load : 0.61 0.29 0.18, AC on-line, battery charging: 100% (5:37)


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
