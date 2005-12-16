From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Adds dB gain to alsa-driver, alsa-lib.
Date: Fri, 16 Dec 2005 12:43:21 +0000
Message-ID: <43A2B669.1080602@superbug.co.uk>
References: <43A1B744.2050703@superbug.co.uk>	<Pine.LNX.4.61.0512151940270.9555@tm8103.perex-int.cz>	<43A1C7F5.6070307@superbug.co.uk>	<s5hlkylz68s.wl%tiwai@suse.de>	<43A29B2A.1000406@superbug.co.uk> <s5hirtpz1pc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> 
> The code won't be compliex nor bload so much as you thought.
> Imagine that you just move the table of dB information into alsa-lib
> like
> 
> 	static struct db_info_lookup table[] = {
> 		{ "ca0106", db_info_ca0106 },
> 		...
> 	};
> 
> The static table could be implemented as an external file, too, of
> course.
> 
> OTOH, the lookup-table in alsa-lib has a drawback that the table must
> includes the whole snd_ctl_elem_id, thus the memory usage about the
> control name will be doubled.  So the actual size might be bigger.
> 
> 
> ... OK, now I've been slowly convinced to add minimal dB information
> to the kernel side.  The further question is the implementation.
> 
> IMO, your method, everything-about-parser-is-in-alsa-lib, is a bit
> exaggerated.  In that way, you'll have to add a different type for
> each driver and chip and end up with endless bloat of new types.
> 
> As Liam suggested, most cases are linear.  They can be embedded in 4
> bytes, including min, max, step and 0dB-offset.  Take a look at
> HD-audio codec or USB-audio specification.
> (BTW, the floating point expression is (still) prohibitied in the
>  kernel code.)
> 
> One exception is the volume muting at the lowest value as often seen
> in ac97 codecs.  This needs a different type.
> More than 90% cases could be coverted by these two types (linear and
> linear+mute), I guess.
> 

In my thoughts, I started with just the hint, then tried what Liam 
described (long before Liam described it. I think we all discussed it a 
some time ago.), and then when back to hint.
The "hint" is also a lot neater on the kernel side.
I am also looking forward to when we finally do have a card-mixer.conf 
config file. We would then put all the conversion function information 
in there. So, when a new card driver appears, one also adds the alsa-lib 
card-pcm.conf and card-mixer.conf and you are done. We already have to 
add the card-pcm.conf file with each new sound card type, so it is not 
adding much bloat.
The "hint" is also perfect for the "reverse conversion" requirement. The 
same "hint" can be the index into the "reverse conversion function" 
lookup as well as the "forward conversion function".

> 
> In addition, some suggestions/questions about your patch:
> 
> - The name snd_ctl_misc sounds too ambiguous

The name "snd_ctl_misc" could be anything. It is not dB specific, 
because that same ioctl could be used for other things. Don't know what 
yet, but some future requirement might need it. I suppose we could call 
is "snd_ctl_tlv" but that is about as descriptive as "snd_ctl_misc"

> 
> - (in kernel) Move the dB-specific stuff out of snd_ctl_elem_misc_user()

Do you just mean move the dB-specific stuff out to it's own function.
I just figured to leave it there for now, as it is quite short. If it 
gets more complicated, we can break it up.

> 
> - TLV parser (e.g. uint32_to_message) should be more optimized :)

True, but hardly important at this stage.

> 
> - As Jaroslav pointed, the parsing of dB information should be in the
>   mixer layer instead of [h]control.

No problem, so move the stuff from
hcontrol.c:snd_hctl_elem_get_db_gain
to
simple_none.c:get_dB_ops
or some extra sub function in simple_none.c

If you mean move the parsing done in
control.c:snd_ctl_elem_get_db_scale
out to simple_none.c, then I don't think we can do that.
The snd_ctl_misc_t is only visible to control.c.

> 
> - How to implement the reverse conversion, from dB to raw?
> 

The "hint" is also perfect for the "reverse conversion" requirement. The 
same "hint" can be the index into the "reverse conversion function" 
lookup as well as the "forward conversion function".

> 
> Takashi
> 
> 

James


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
