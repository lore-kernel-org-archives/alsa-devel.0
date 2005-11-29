From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Where to put code for a new ioctl.
Date: Tue, 29 Nov 2005 08:55:54 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0511290853340.10328@tm8103.perex-int.cz>
References: <4389943D.20100@superbug.co.uk> <s5hoe45knec.wl%tiwai@suse.de>
 <Pine.LNX.4.61.0511281251250.9343@tm8103.perex-int.cz> <438B52DB.4070606@superbug.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <438B52DB.4070606@superbug.co.uk>
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 28 Nov 2005, James Courtier-Dutton wrote:

> I can't see step (3) being achievable without a ioctl.

I see. You should check the vendor/subvendor/codec and other IDs from the 
driver and then choose the proper conversion table / expression in 
alsa-lib. I added the 'components' field to the control info structure 
some time ago exactly for this purpose. If some identification is missing, 
it should be added to the lowlevel driver.

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
