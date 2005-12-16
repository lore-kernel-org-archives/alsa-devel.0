From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] Adds dB gain to alsa-driver, alsa-lib.
Date: Fri, 16 Dec 2005 13:14:38 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0512161311380.10849@tm8103.perex-int.cz>
References: <43A1B744.2050703@superbug.co.uk> <Pine.LNX.4.61.0512151940270.9555@tm8103.perex-int.cz>
 <43A1C7F5.6070307@superbug.co.uk> <s5hlkylz68s.wl%tiwai@suse.de>
 <43A29B2A.1000406@superbug.co.uk> <s5hirtpz1pc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hirtpz1pc.wl%tiwai@suse.de>
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
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 16 Dec 2005, Takashi Iwai wrote:

> OTOH, the lookup-table in alsa-lib has a drawback that the table must
> includes the whole snd_ctl_elem_id, thus the memory usage about the
> control name will be doubled.  So the actual size might be bigger.

I don't think so. The card specific code can be called using a callback
and the callback might provide the data lookup quite efficiently, so
not all or only partial parts from snd_ctl_elem_id can be there.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
