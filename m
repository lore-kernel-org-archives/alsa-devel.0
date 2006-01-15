From: Mark Salazar <markTheCoder@justmyself.net>
Subject: Re: [es18xx.c PATCH] #1/4 for Zoom Video - resolve common
 vs chipset specific mixer controls
Date: Sun, 15 Jan 2006 15:30:06 -0500
Message-ID: <43CAB0CE.2040602@justmyself.net>
References: <43B00FF2.6030007@justmyself.net>	<1135613234.8293.38.camel@mindpipe>	<43B02A0E.20401@justmyself.net>	<s5h8xtyr9oh.wl%tiwai@suse.de>	<43C199C1.1050301@justmyself.net>	<s5hwth9ha4b.wl%tiwai@suse.de>	<43C306AA.4030900@justmyself.net> <s5hu0ccfgu6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu0ccfgu6.wl%tiwai@suse.de>
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
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

>
>Basically, rewriting the static array and restoring it looks odd, so
>I prefer having multiple kcontrol_new arrays.  (Besides, you could use
>simply NULL for the validity check.)  From the readability viewpoint,
>separate arrays are better, too.  The most important point is that the
>code flow is straightforward. 
>
>
>Takashi
>
>  
>
OK, I've tried your version of mod1 and it seems to work fine.

Also retested the patches for mods 2 & 3 ... no changes necessary.

Revised mod4 patch to follow.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
