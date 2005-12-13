From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Re: snd-es1968 (+ snd-cs4236) trouble
Date: Tue, 13 Dec 2005 21:24:51 +0100
Message-ID: <439F2E13.7070405@keyaccess.nl>
References: <439B36E0.3090709@keyaccess.nl>	<s5hzmn6y1b1.wl%tiwai@suse.de>	<439DFF60.1020105@keyaccess.nl>	<439E7391.60408@keyaccess.nl> <s5h3bkxxnpv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl [213.51.146.200])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CE2E31C3
	for <alsa-devel@alsa-project.org>; Tue, 13 Dec 2005 21:20:58 +0100 (MET)
In-Reply-To: <s5h3bkxxnpv.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:

> Good catch.  I thought TDMA is the timer DMA for es1968, and never
> thought it conflicts with ISA DMAs.

"Transparent DMA", some ESS specific "ISA-DMA on PCI" thing, it seems.

> Just to be sure, doesn't it break es1968 itself, right?

No, snd-es1968 is fine with it applied. Listening to it currently...

> I'll apply it to CVS after releasing 1.0.11-rc1.  (Don't worry, rc2
> will come soon later :) 

I'll poke around some more to confirm the documentation was right about 
the Legacy Audio bit. I see the SB-EMU can be set to 0x240 and that's 
free here, so I'll try and see for which setting of the bit something 
appears there. Once done, I'll confirm the previously mailed patch, or 
submit a change again against the then current situation.

Rene.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
