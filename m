From: Duncan Sands <baldrick@wanadoo.fr>
Subject: Re: 2.5.50: sleeping function called from illegal context
Date: Tue, 3 Dec 2002 07:39:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200212030739.52669.baldrick@wanadoo.fr>
References: <200212030407.53337.baldrick@wanadoo.fr> <200212030657.45283.baldrick@wanadoo.fr> <s5hhedv9mng.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhedv9mng.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> yes, basically what snd_ctl_notify() does is the same.
> it queues an event and wakes up the sleepers.
> thus, it's ok to separate the stuff from the semaphore.
>
> the attached is a patch to rewrite the locks with rwsem.
> please check whether it works for you.

This is against alsa cvs and not 2.5.50, right?  That means
it will take me a little longer to test it (but I will test it).

Thanks a lot,

Duncan.


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
