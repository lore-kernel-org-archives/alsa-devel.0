From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Adds dB gain to alsa-driver, alsa-lib.
Date: Thu, 15 Dec 2005 19:45:57 +0000
Message-ID: <43A1C7F5.6070307@superbug.co.uk>
References: <43A1B744.2050703@superbug.co.uk> <Pine.LNX.4.61.0512151940270.9555@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0512151940270.9555@tm8103.perex-int.cz>
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
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Thu, 15 Dec 2005, James Courtier-Dutton wrote:
> 
> 
>>I have implemented dB gain reporting for ALSA mixer controls.
>>By applying the attached patches to alsa-driver and alsa-lib, one will then
>>see dB values appear in alsamixer. (I added support to alsamixer a long time
>>ago)
>>
>>Currently, only the snd-ca0106 sound card reports the values.
> 
> 
> NACK.
> 
> 1) The midlevel code should not know anything about dB scale or so...
>    It should handle only universal containter / TLV stuff per control.
>    I'm talking about dB_scale members etc. The TLV should be obtained
>    from the lowlevel driver using a callback like get. You can provide
>    the library function to manage TLV in the control midlevel code.

I was viewing the TLV as simply a transport across the IOCTL interface.
If one needs to use a new TLV, one would have to implement a new 
function in control.c in alsa-lib.
I have put the volume to db_gain calculation in hcontrol.c, but it could 
just as easily be in simple_none.c.

> 2) The ca0106 driver is not candidate for such info. The info should
>    be static somewhere in alsa-lib, probably in the src/control/control.c
>    and added only when TLV stuff is requested.

What "info" are you talking about? If you are talking about the db_scale 
information, then I disagree with you on this point and I explained why 
some time ago in a previous thread. I think Takashi agreed with me in 
the end, once I managed to fully explain the reasons.

> 3) I'm still not sure to use integers as keys in the TLV 
>    tree. Of course, it's more efficient than string handling, but
>    I think that it's not an issue because the amount of transferred
>    data is low.

It if flexible. TLV allows for the value to be integer, string, 
ip-address, anything in fact.
If you mean "key" where I say "Type" in the TLV, then integers is 
certainly the best way to go. Then the nesting provides for re-use of 
"Type" numbers. Using strings as the "Type" or "key" just adds bloat, 
with no real benefit.

> 4) Nesting. Do we need this on the driver side? The key might contain
>    multiple "sub-keys". If we have this information static, it might be
>    more efficient than your implementation.

Efficient in what way?
The current method is efficient in that it is implemented using very few 
lines of code, and thus not much code bloat.

> 
> So, what about this (use integers as keys):
> 
> - one key - max 8 * 32-bit subkeys
> - value   - depending on subkeys, store only the size, might be binary
> 
> or (use strings as keys):
> 
> - one key - max 8 * 16 byte subkeys (ASCII string)
> - value   - depending on subkeys, store only the size, might be binary
>

Why do you want to place limits on the size of the request/response?

> So the key lookup function will handle max. 256 bytes which is no so bad.
> The lowlevel driver might use some key-lookup library functions in the 
> control midlevel code like snd_control_key_is_db_scale() or so and put
> directly the data in the get_key() callback to value area.
> 
> Perhaps, we can use 8 byte strings (it's enough) or use 64-bit values for 
> sub-keys which might represent strings (I can imagine that first sub-key 
> will be string and rest of sub-keys might be indexes, strings, 64-bit 
> values, 64-bit masks etc.).
> 
> In future, if 8-subkeys are not enough, we may create a new ioctl which 
> will add more space to the whole key. The old ioctl might be simply 
> emulated with the conversion to new one.
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SUSE Labs
> 
> 



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
