From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: Re: [PATCH] Adds dB gain to alsa-driver, alsa-lib.
Date: Fri, 16 Dec 2005 14:55:18 +0000
Message-ID: <1134744918.22774.62.camel@cearnarfon>
References: <43A1B744.2050703@superbug.co.uk>
	 <Pine.LNX.4.61.0512151940270.9555@tm8103.perex-int.cz>
	 <43A1C7F5.6070307@superbug.co.uk> <s5hlkylz68s.wl%tiwai@suse.de>
	 <43A29B2A.1000406@superbug.co.uk> <s5hirtpz1pc.wl%tiwai@suse.de>
	 <43A2B669.1080602@superbug.co.uk> <s5hfyotyxws.wl%tiwai@suse.de>
	 <43A2C57F.6020503@superbug.co.uk> <s5hd5jxyvwh.wl%tiwai@suse.de>
	 <Pine.LNX.4.61.0512161509230.10849@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0512161509230.10849@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-12-16 at 15:11 +0100, Jaroslav Kysela wrote:
> On Fri, 16 Dec 2005, Takashi Iwai wrote:
> 
> > The trick is to define "step".  Then min/max can be usually within
> > 8 bits.  I recommend you to take a look at HD-audio specification, for
> > example.
> 
> Just short note: Wouldn't be better to use a RPN expression to describe dB 
> <-> raw conversions like rrdtool uses? Just idea (of course that everybody 
> tells me that it's overkill).
> 

I think it might just be overkill :) as whoever is writing the driver
code will probably just lift the values from the codec data sheet. The
data sheets I've seen typically just specify the dB range and step size.

Liam  



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
