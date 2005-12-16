From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH] Adds dB gain to alsa-driver, alsa-lib.
Date: Fri, 16 Dec 2005 11:09:25 +0000
Message-ID: <1134731365.22774.21.camel@cearnarfon>
References: <43A1B744.2050703@superbug.co.uk>
	 <Pine.LNX.4.61.0512151940270.9555@tm8103.perex-int.cz>
	 <43A1C7F5.6070307@superbug.co.uk>  <s5hlkylz68s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hlkylz68s.wl%tiwai@suse.de>
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
Cc: James Courtier-Dutton <James@superbug.co.uk>, Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-12-16 at 11:27 +0100, Takashi Iwai wrote:

> 
> Err, then it's a misunderstanding.  I'm also against inclusion of
> unnecessary code in the kernel.  That is, if the dB information for
> each control is static and unchanged, it shouldn't be embedded in the
> driver.
> 

I also agree that some dB information shouldn't be in the kernel (e.g.
lookup tables), however I think it makes sense for simple controls with
a linear dB step size to be within the driver. 

I'd like to be able to do something like:-

SOC_SINGLE("Left ADC Capture Volume", WM8753_LADC, 0, 63, 0, DB(-17.25,
0.75),

This describes a control with a dB gain starting at -17.25 and in
increments of 0.75dB. The dB info could be represented in hex as
follows:-

0.75db = 0xC
1.00 db = 0x10 
-1.00 dB = 0x8010 (assuming we are using a short)

With a little extra effort the dB code could be extended to pass ALC
timeout information.

Liam



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
