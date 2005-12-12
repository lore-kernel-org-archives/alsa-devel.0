From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] make the pxa2xx-ac97 module more robust against PXA27x bugs
Date: Mon, 12 Dec 2005 10:25:48 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512121025040.26663@localhost.localdomain>
References: <Pine.LNX.4.64.0512091537350.26663@localhost.localdomain>
 <s5h64puzhf6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <s5h64puzhf6.wl%tiwai@suse.de>
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

On Mon, 12 Dec 2005, Takashi Iwai wrote:

> At Fri, 09 Dec 2005 15:48:01 -0500 (EST),
> Nicolas Pitre wrote:
> > 
> > The SDONE and CDONE interrupt on the PXA27x might become unusable in 
> > some conditions.  Let's use an hybrid approach (interrupt with timeout) 
> > to have the best possible behavior in all conditions.
> > 
> > Also let's not care about CAR_CAIP anymore.  This is useless.
> > 
> > Signed-off-by: Nicolas Pitre <nico@cam.org>
> 
> Could you regenerate the patch to the latest ALSA CVS version, so that
> it's included in the upcoming 1.0.11-rc1?
> Because of recent changes, the patch can't be applied.

Sure, Updated patch follows.


Nicolas


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
