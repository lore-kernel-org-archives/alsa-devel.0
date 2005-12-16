From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [PATCH] Adds dB gain to alsa-driver, alsa-lib.
Date: Fri, 16 Dec 2005 15:11:57 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0512161509230.10849@tm8103.perex-int.cz>
References: <43A1B744.2050703@superbug.co.uk> <Pine.LNX.4.61.0512151940270.9555@tm8103.perex-int.cz>
 <43A1C7F5.6070307@superbug.co.uk> <s5hlkylz68s.wl%tiwai@suse.de>
 <43A29B2A.1000406@superbug.co.uk> <s5hirtpz1pc.wl%tiwai@suse.de>
 <43A2B669.1080602@superbug.co.uk> <s5hfyotyxws.wl%tiwai@suse.de>
 <43A2C57F.6020503@superbug.co.uk> <s5hd5jxyvwh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd5jxyvwh.wl%tiwai@suse.de>
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

> The trick is to define "step".  Then min/max can be usually within
> 8 bits.  I recommend you to take a look at HD-audio specification, for
> example.

Just short note: Wouldn't be better to use a RPN expression to describe dB 
<-> raw conversions like rrdtool uses? Just idea (of course that everybody 
tells me that it's overkill).

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
