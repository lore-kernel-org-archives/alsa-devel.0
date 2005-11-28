From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Where to put code for a new ioctl.
Date: Mon, 28 Nov 2005 21:23:52 +0000
Message-ID: <438B7568.2000400@superbug.co.uk>
References: <4389943D.20100@superbug.co.uk>	<s5hoe45knec.wl%tiwai@suse.de>	<Pine.LNX.4.61.0511281251250.9343@tm8103.perex-int.cz>	<438B52DB.4070606@superbug.co.uk> <s5hmzjok2dv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
To: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> 
> The dB information for most drivers is static.  That is, it doesn't
> have to be in kernel space at all.  The whole information is known.
> 
> So, what you need is to identify the driver and the matching codec,
> and to obtain the dB information (scale, resolution and offset) for
> each control element of the given configuration.
> 
> In the case of user-space solution, the scenario would be like the
> following:
> The h/w configuration can be retrieved via cardinfo and card
> components (for codec ids, etc).  Then, access to a database on
> user-space to obtain the dB information.  The database doesn't have to
> be a too complex one.  We can reuse the alsa-lib's config space and
> separate files with driver and codec ids, for example.

This all sounds rather messy to me. If we just take the intel8x0 driver 
as an example. It's controls are fixed once the kernel module has 
loaded, but even knowing the controller chip and the ac97 codec being 
used, one still does not have complete information. One has to then take 
into account all the quirks on the different boards.

> 
> 
>>I am therefore implementing an ioctl to handle (3) in control.c.
>>Any low level driver not implementing this ioctl will simply result in 
>>dB values not being shown in the alsamixer. i.e. current behavior.
>>
>>(3) can be implemented in a number of different ways. I am intending to 
>>implement it in as flexible way as possible using TLVs.
> 
> 
> It's fine with TLV.  But please don't implement it on kernel space for
> drivers without dynamic configuration.  A user-space database is
> much more flexible than strictly bound to kernel drivers.
> 
> Also, (4) isn't too easy in some cases.  It's not always logarithmic
> linear.  For example, some ac97 codecs have +gain, and it's not the
> same curve as the attenuation.  In addition, some codecs have a linear
> volume.  This has to be converted to log.
> 
> 
> Takashi
> 
> 

So what about a mix of the two.
1) kernel space adding one extra parameter to each mixer control 
registration. The extra parameter will simply be: index into dB function.
2) alsa-lib then contains a database of all the different conversion 
functions, and simply uses the "index" to select the appropriate 
function for this particular gain control.

This will add minimal complexity to the kernel modules, and at the same 
time simplify the user land code.

Now, I think that the best way for me to get to a balanced view on what 
needs doing in user space, is for me to understand what other features 
apart from dB gain conversion, do we have planned for user space mixers.
I know Jaroslav has been working on lisp config files for the mixer, 
just like we have for the pcm, but I have not seen any detains of what 
he is actually planning to do within the mixer config file.

I suppose one think that might be needed is language options for the 
mixer control names.
What else?

James


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
