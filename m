From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: snd-es1968 (+ snd-cs4236) trouble
Date: Mon, 12 Dec 2005 23:53:20 +0100
Message-ID: <439DFF60.1020105@keyaccess.nl>
References: <439B36E0.3090709@keyaccess.nl> <s5hzmn6y1b1.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl [213.51.146.200])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B0B721AD
	for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2005 23:49:36 +0100 (MET)
In-Reply-To: <s5hzmn6y1b1.wl%tiwai@suse.de>
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

>>The second I modprobe snd-es1968, snd-cs4236 stops working. If I'm 
>>listening to snd-cs4236 at the time I get the last second or so repeated 
>>over and over again. Killing the app that was playing via kill -9 works 
>>and stops the repeating sound but does not repair things: when I try to 
>>use snd-cs4236 again after that, it's still the same -- I only get the 
>>first second or so repeated over and over.
> 
> 
> This sounds like an irq problem.  But, still it's weird because cs4236
> is ISA and should be basically intact from PCI driver.  One
> possibility is that es1968 has a legacy feature to emulate ISA WSS or
> SB ports, and this conflicts although they are disabled in the driver
> code.

Good point; when you mentioned this I remembered very similar behavior 
with old ISA soundcards when there was a DMA channel conflict or 
mis-setting.

The ISA CS4236 was using standard DMA 1/0 (playback/record); when I 
force it to use channel 3 for playback, the problem is gone. It seems 
then the PCI ESS chip grabs DMA1 for the legacy stuf which conflicts 
with ISA. Haven't tested capture extensively yet, but it appears that 
channel 0 is okay..

Both drivers _can_ be loaded under Windows 98SE, so there's probably a 
way to tell the chip to reallyreally not enable the legacy stuff.

More detail: the card's a TerraTec SoundSystem DMX version 1.2, with the 
"ESS Canyon-3D" aka ES1970MS-3D (and a Sigmatel STAC9407T) which is 
detected by ALSA as a "ESS ES1978 (Maestro-2E)". Probably not a problem...

I see there's no datasheet available specifically for the ES1970, but 
I'll try to see if I can find anything in the 1969 or 1978 docs. Please 
beat me to it though... :-)

Rene.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
