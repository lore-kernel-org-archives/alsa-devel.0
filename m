From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Adds dB gain to alsa-driver, alsa-lib.
Date: Fri, 16 Dec 2005 13:47:43 +0000
Message-ID: <43A2C57F.6020503@superbug.co.uk>
References: <43A1B744.2050703@superbug.co.uk>	<Pine.LNX.4.61.0512151940270.9555@tm8103.perex-int.cz>	<43A1C7F5.6070307@superbug.co.uk>	<s5hlkylz68s.wl%tiwai@suse.de>	<43A29B2A.1000406@superbug.co.uk>	<s5hirtpz1pc.wl%tiwai@suse.de>	<43A2B669.1080602@superbug.co.uk> <s5hfyotyxws.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfyotyxws.wl%tiwai@suse.de>
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
>>In my thoughts, I started with just the hint, then tried what Liam 
>>described (long before Liam described it. I think we all discussed it a 
>>some time ago.), and then when back to hint.
>>The "hint" is also a lot neater on the kernel side.
> 
> 
> Well, the composition of 4-bytes info can be done via a macro, so it's
> even more readable than a strange index.

How do you propose that 4 separate bytes composed will contain enough 
information. Some of the current volume controls range more than 0-255.

> 
> 
>>I am also looking forward to when we finally do have a card-mixer.conf 
>>config file. We would then put all the conversion function information 
>>in there.
> 
> 
> This will result in the bloat exactly as same as you pointed in your
> last mail.

But a lot less bloat than the alternative or user land only.

> 
> 
>> So, when a new card driver appears, one also adds the alsa-lib 
>>card-pcm.conf and card-mixer.conf and you are done. We already have to 
>>add the card-pcm.conf file with each new sound card type, so it is not 
>>adding much bloat.
> 
> 
> If you introduce the extra data and the extra parsing/handling codes
> for each driver/control type, then there is no merit to embed the
> information in the kernel at all.  The only merit to have information
> in the kernel is to reduce the total size.

Untrue, it will still result is a lot less bloat than a user land only 
solution

> 
> 
>>The "hint" is also perfect for the "reverse conversion" requirement. The 
>>same "hint" can be the index into the "reverse conversion function" 
>>lookup as well as the "forward conversion function".
> 
> 
> Ditto for the composed info.  It's pretty reversible.
> 
> The composed information is not perfect at all.  But it can conver
> most things.  That's the point.

We can't ignore the edge cases where the composed information will not 
be suitable. How do you propose to support them?

> 
> 
> 
>>>In addition, some suggestions/questions about your patch:
>>>
>>>- The name snd_ctl_misc sounds too ambiguous
>>
>>The name "snd_ctl_misc" could be anything. It is not dB specific, 
>>because that same ioctl could be used for other things. Don't know what 
>>yet, but some future requirement might need it. I suppose we could call 
>>is "snd_ctl_tlv" but that is about as descriptive as "snd_ctl_misc"
> 
> 
> Sure, I understood that it's to be generic.  But, snd_ctl_misc...
> misc what?  I'd better understand if it's called snd_ctl_misc_info.
> Anyway, I leave this decision to native english speaker.
> 
> 
>>>- (in kernel) Move the dB-specific stuff out of snd_ctl_elem_misc_user()
>>
>>Do you just mean move the dB-specific stuff out to it's own function.
>>I just figured to leave it there for now, as it is quite short. If it 
>>gets more complicated, we can break it up.
> 
> 
> The current code looks messy and far from the concenpt to be generic.
> 
> 
>>>- TLV parser (e.g. uint32_to_message) should be more optimized :)
>>
>>True, but hardly important at this stage.
> 
> 
> For example, you call kmalloc at each time for this ioctl.  This can
> be better done by direct read. 
> Such implementation details may influence on the definition,
> e.g. reducing the struct size, etc.
> 
> 
>>>- As Jaroslav pointed, the parsing of dB information should be in the
>>>  mixer layer instead of [h]control.
>>
>>No problem, so move the stuff from
>>hcontrol.c:snd_hctl_elem_get_db_gain
>>to
>>simple_none.c:get_dB_ops
>>or some extra sub function in simple_none.c
>>
>>If you mean move the parsing done in
>>control.c:snd_ctl_elem_get_db_scale
>>out to simple_none.c, then I don't think we can do that.
>>The snd_ctl_misc_t is only visible to control.c.
> 
> 
> How about to simply pass snd_ctl_misc_t to the higher layer?
> We don't have to export this function to external.
> 

I thought one of the points of the layers was to hide stuff below it.
Your suggestion just breaks that.

> 
> Takashi
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
