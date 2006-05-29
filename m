From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: dB gain
Date: Mon, 29 May 2006 15:50:01 +0100
Message-ID: <447B0A19.2050408@superbug.co.uk>
References: <4478A290.80702@superbug.co.uk> <s5hverp7zcr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-31.mail.demon.net (anchor-post-31.mail.demon.net
	[194.217.242.89])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BAE4414E
	for <alsa-devel@alsa-project.org>;
	Mon, 29 May 2006 16:50:02 +0200 (MEST)
In-Reply-To: <s5hverp7zcr.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Sat, 27 May 2006 20:03:44 +0100,
> James Courtier-Dutton wrote:
>> Hi,
>>
>> I have made a new attempt at adding support for dB gain reports in
>> alsamixer.
>>
>> See the attached diffs against the current alsa hg repository. 27-5-2006
>>
>> It shows an example of support for the snd-ca0106 driver.
>> As one can see, this adds minimal amounts of code to each sound card
>> driver. 22 new lines + 1 per volume control making 33 lines total.
>>
>> Any comments?
> 
> Apart from some small implementation details, it looks almost fine.
> One remaining thing is the definition of protocol.  Shouldn't be numid
> regardless of container type?  Now the numid is checked inside the
> block of db container type.  I think this can be outside.
> 
> Also, a bit more sensible names are preferred for new stuff.
> "misc" sounds too ambiguous to me, and "info2" is...
> 
> I'm not a native speaker, so I expect someone elese has better
> proposal.
> 
> 
> Takashi

As for the naming, I called it misc because it can be used for anything
we want, depending on the TLVs requested. "misc" is short for
miscellaneous. So I thing that "misc" is appropriate, given it's
potential to be used for other stuff in future.


An explanation of the protocol:

The protocol is a request/response protocol
Request:
uint32_t version; // Protocol version
uint32_t length;  // Length of the user land data buffer. This is filled
with the response.
uint8_t data[];   // A block of data bytes malloc by user land,
containing the actual "request".

Inside the data one has TLVs (Type, Length, Values)

For requesting db gain scales:
Request:
uint32_t type = SND_MISC_DB_SCALE;
uint32_t length = 4; /* sizeof(following uint32_t)
uint32_t value = numid; /* Used by snd_ctl_find_numid() */

Note: numid is used because it is present in both userland and kernel
land as a unique identifier of the mixer control in question.
Of course, if we wished to get some different information, the type
would be a different value, and the resulting value could relate to
something else. How the value is interpreted is dependent on the type field.

Response:
This depends on the function used to do the conversion.
uint32_t type = SND_MISC_DB_SCALE;
uint32_t length = length of following data; /* In this example it will
be 20 */
uint8_t data[]  /* data returned from sound card driver info2() */

Note: the info2(kctl, 1, &info2). The "1" tells the driver to return
info2 info about the db_gain function.
For example, if it was "2", we could(not implemented yet) get the driver
to return all the info returned in the current info() function, but in
TLV form.

In a simple example the data[] contains:
uint32_t type = 1  /* For simple  dB = (X * db_per_devision) - db_offset */
uint32_t length = 12 /* 3 following uint32_t */
int32_t db_per_devision; /* Use db per devision * 100 */
int32_t db_offset; /* Use dB offset * 100. This identifies the 0dB point */
int32_t db_mute; /* The value, before conversion, that is equivalent to
MUTE */

There is the potential to request multiple parameters by encapsulating
more different TLVs in the same request, but this example only used one
for simplicity.

If the conversion, % to dB, function is more complex, on would add a new
type, e.g. 2, and then as much data as needed to describe the function.
One would then implement the type 2 processing in alsa-lib.

If there is a mismatch, and the user lib is of a different version from
the kernel, and the required type is not implemented, the GUI mixer app
would simply not display dB gain levels, as is the case with the current
 alsamixer.

James
