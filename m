From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Adds dB gain to alsa-driver, alsa-lib.
Date: Fri, 16 Dec 2005 13:08:08 +0000
Message-ID: <43A2BC38.5060001@superbug.co.uk>
References: <43A1B744.2050703@superbug.co.uk> <Pine.LNX.4.61.0512151940270.9555@tm8103.perex-int.cz> <43A1C7F5.6070307@superbug.co.uk> <Pine.LNX.4.61.0512161323540.10849@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0512161323540.10849@tm8103.perex-int.cz>
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
>>Efficient in what way?
>>The current method is efficient in that it is implemented using very few lines
>>of code, and thus not much code bloat.
> 
> 
> That's a question. I'm trying to propose something simple which can be
> handled in most easy way.
> 
> 
>>Why do you want to place limits on the size of the request/response?
> 
> 
> No, the limits will be similar as yours. If you have 2048 bytes for ioctl 
> request, there is plenty space for the response values.
> 
> My question is what is better: The static structure or dynamically created
> containers.
> 
> With my proposal, the lowlevel driver can handle only such callbacks:
> 
> struct snd_ctl_extra {
> 	unsigned char key[8][8];
> 	unsigned char value[2048-256];
> };
> 
> static int usb_control_get_extra_info(struct snd_kcontrol *kcontrol, 
> 				      struct snd_ctl_extra *extra)
> {
> 	if (!strcmp(extra->key[0], "dB Scale")) {
> 		*((unsigned int *)extra) = 0x11223344;
> 		return 0;
> 	}
> 	return -ENOENT;
> }
> 
> As you see:
> 
> 1) no value size encoding / decoding (size is already known, because it is 
>    assigned to key)
> 2) the callback can be shared among many controls (ususally one lowlevel
>    driver has many controls with same dB scale values)
> 3) extra code for specific controls might be handled in the extra callback
>    as 'if (kcontrol == driver->my_specific_kcontrol) { do_it; return 0; }'
> 
> 						Jaroslav
> 

Once the call gets into the kernel, whether it gathers the required 
information via a callback or just grabbing a value from a kernel 
structure makes very little difference. For the db_scale "hint", I 
though a callback was overkill, but some other value might be more 
complex and thus need a callback.

Currently my struct snd_ctl_misc is:
struct sndrv_ctl_misc {
         unsigned int type;
         unsigned int length;
         unsigned char message[2040];
};

What I was hoping for was something like this:
struct sndrv_ctl_misc {
         unsigned int type;
         unsigned int length;
         unsigned char message[];   /* Size variable */
};

The length would then contain the length of the message buffer that user 
land has allocated.

I did not actually try it yet though. That would at least make this api 
totally future proof.

Your static structure idea seems a little more constraining than my 
method. Although, at the moment I have no idea if in future we will need 
more than 8 keys or not, or whether they need to be nested or not, but 
at least my method does not rule those out.
I was thinking that a possible addition to my method would be a batch 
request. I.e. alsa-lib makes one request for all mixer elements, and my 
method would then need nesting in order to return the multiple element 
information fields.
Or, if one wanted the db_scale and some other information about a 
particular mixer element, then nesting would be needed.

James


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
