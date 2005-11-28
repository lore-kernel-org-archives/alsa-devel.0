From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: Where to put code for a new ioctl.
Date: Mon, 28 Nov 2005 19:33:05 +0000
Message-ID: <1133206386.3369.17.camel@localhost.localdomain>
References: <4389943D.20100@superbug.co.uk> <s5hoe45knec.wl%tiwai@suse.de>
	 <Pine.LNX.4.61.0511281251250.9343@tm8103.perex-int.cz>
	 <438B52DB.4070606@superbug.co.uk>  <s5hmzjok2dv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hmzjok2dv.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-11-28 at 20:18 +0100, Takashi Iwai wrote:
> 
> Also, (4) isn't too easy in some cases.  It's not always logarithmic
> linear.  For example, some ac97 codecs have +gain, and it's not the
> same curve as the attenuation.  In addition, some codecs have a linear
> volume.  This has to be converted to log.
> 
> 

To further complicate things, some codecs can even have their gain step
size altered. e.g. gain/attenuation for some volumes can be either in
0.75 or 1.5 dB steps.

Liam



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
