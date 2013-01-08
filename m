From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: hda - print power state for AFG node
	in proc file
Date: Tue, 08 Jan 2013 15:26:03 +0100
Message-ID: <50EC2C7B.1000500@canonical.com>
References: <1357653679-5997-1-git-send-email-david.henningsson@canonical.com>
 <s5h1udvpxw9.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 8546D2615F5
 for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2013 15:26:03 +0100 (CET)
In-Reply-To: <s5h1udvpxw9.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/08/2013 03:11 PM, Takashi Iwai wrote:
> At Tue,  8 Jan 2013 15:01:18 +0100,
> David Henningsson wrote:
>>
>> It seems useful, and power states are required for AFG nodes,
>> so I see no reason not to print it.
>
> Hmm...  when the codec proc file is output, the codec gets awake.
> So it should print only D0 there.  Or did you get other power state?

I added it to debug something, to verify that I actually did get D0. And 
yes, I did get D0.

But there is a possibility not to get D0; I mean, we try ten times to 
set it (and wait 500 ms for each try!) and maybe, some codecs might need 
it to be set eleven times...or something.

And it also prints out available power states, e g whether the AFG 
supports EPSS etc.

Do you think it would be more useful to move it above snd_hda_power_up?

>
>> As a bonus, also print the
>> AFG nid.
>
> Yeah, this is a good thing.
>
>
> thanks,
>
> Takashi
>
>> Signed-off-by: David Henningsson <david.henningsson@canonical.com>
>> ---
>>   sound/pci/hda/hda_proc.c |    2 ++
>>   1 file changed, 2 insertions(+)
>>
>> (Feel free to rephrase "State of AFG node 0x%02x:\n" if you like.)
>>
>> diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
>> index 045e5d3..d6c8416 100644
>> --- a/sound/pci/hda/hda_proc.c
>> +++ b/sound/pci/hda/hda_proc.c
>> @@ -603,6 +603,8 @@ static void print_codec_info(struct snd_info_entry *entry,
>>   	print_amp_caps(buffer, codec, codec->afg, HDA_INPUT);
>>   	snd_iprintf(buffer, "Default Amp-Out caps: ");
>>   	print_amp_caps(buffer, codec, codec->afg, HDA_OUTPUT);
>> +	snd_iprintf(buffer, "State of AFG node 0x%02x:\n", codec->afg);
>> +	print_power_state(buffer, codec, codec->afg);
>>
>>   	nodes = snd_hda_get_sub_nodes(codec, codec->afg, &nid);
>>   	if (! nid || nodes < 0) {
>> --
>> 1.7.9.5
>>
>



-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
