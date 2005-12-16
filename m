From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Adds dB gain to alsa-driver, alsa-lib.
Date: Fri, 16 Dec 2005 10:47:06 +0000
Message-ID: <43A29B2A.1000406@superbug.co.uk>
References: <43A1B744.2050703@superbug.co.uk>	<Pine.LNX.4.61.0512151940270.9555@tm8103.perex-int.cz>	<43A1C7F5.6070307@superbug.co.uk> <s5hlkylz68s.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Thu, 15 Dec 2005 19:45:57 +0000,
> James Courtier-Dutton wrote:
> 
>>>2) The ca0106 driver is not candidate for such info. The info should
>>>   be static somewhere in alsa-lib, probably in the src/control/control.c
>>>   and added only when TLV stuff is requested.
>>
>>What "info" are you talking about? If you are talking about the db_scale 
>>information, then I disagree with you on this point and I explained why 
>>some time ago in a previous thread. I think Takashi agreed with me in 
>>the end, once I managed to fully explain the reasons.
> 
> 
> Err, then it's a misunderstanding.  I'm also against inclusion of
> unnecessary code in the kernel.  That is, if the dB information for
> each control is static and unchanged, it shouldn't be embedded in the
> driver.
> 
> I agree to add a new ioctl for drivers with dynamic controls or
> the drivers taking the dB information from the codec chip.
> The former case is emu10k1, which mixer can be changed via ld10k1.
> The latter case is usb-audio and hda-intel.
> 
> Since the number of drivers requring this ioctl should be relatively
> small, I suppose that the implementation would be hardware-dependent.
> So, a generic "hint" and a dedicated parser in alsa-lib would suffice,
> rather than defining a too complicated struct to cover everyhing about
> dB.
> 
> The case of ac97 needs a further investigation.  I believe it can be
> implemented well in alsa-lib, but the implementation on the driver
> side _might_ be more efficient.  Let's see the code.
> 
> 
> Takashi
> 
> 

Ok, somone else can write this. I give up.

Your solution is going to break down in the edge cases, and mine adds 
just 4 bytes to each mixer control structure in the kernel. No extra 
code at all to each driver. Just some lines of extra core code to handle 
the new ioctl.

Your suggestions will add considerably to code bloat in the alsa-lib, 
and probably not work very well due to the edge cases.

James


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
