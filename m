From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: matrix mixer control (Re: Complex mixer questio
Date: Tue, 01 Apr 2003 09:23:09 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E190MZY-0002rp-00@sc8-sf-list1.sourceforge.net>
References: <3E893713.20806@libero.it>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 01 Apr 2003 08:52:03 +0200."
             <3E893713.20806@libero.it>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Abramo Bagnara <abramo.bagnara@libero.it>
Cc: Jaroslav Kysela <perex@suse.cz>, Giuliano Pochini <pochini@shiny.it>, alsa-devel <alsa-devel@lists.sourceforge.net>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

>I agree with Jaroslav fully:

i agree fully with you. i'm not clear that this is what jaroslav was
proposing, but if so, then it seems good to me.

>- have one ALSA control for each primitive hw control (1536 different 
>controls)
>- add a field to struct sndrv_ctl_elem_info explaining how index field 
>of sndvr_ctl_elem_id should be interpreted (32,16+16,10+11+11, ecc.)


-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
