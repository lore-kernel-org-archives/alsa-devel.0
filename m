From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: RME HDSP9652
Date: Fri, 29 Nov 2002 12:20:29 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18Hoka-0007VO-00@sc8-sf-list1.sourceforge.net>
References: <s5hwumxzoqd.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Thu, 28 Nov 2002 16:40:58 +0100."
             <s5hwumxzoqd.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Justin Cormack <justin@street-vision.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> Its the same PCI ID, but insmod segfaults...
>
>does the attched patch cure the segfault?
>but it doesn't mean that your card will be supported by it :)

takashi - thanks for this patch. i didn't understand that
snd_hdsp_free() could be called when no hardware was detected. now i do :)

--p


-------------------------------------------------------
This SF.net email is sponsored by: Get the new Palm Tungsten T 
handheld. Power & Color in a compact size! 
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0002en
