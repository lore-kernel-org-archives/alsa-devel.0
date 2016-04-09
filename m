From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH 1/2] sound: usb: add UAC2 clock sources as
	mixer controls
Date: Sat, 9 Apr 2016 11:09:26 +0200
Message-ID: <5708C6C6.8060702@zonque.org>
References: <1460137922-8993-1-git-send-email-daniel@zonque.org>
 <s5hlh4ncgtz.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 475602615F7
 for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2016 11:09:28 +0200 (CEST)
In-Reply-To: <s5hlh4ncgtz.wl-tiwai@suse.de>
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
Cc: orm.finnendahl@selma.hfmdk-frankfurt.de, alsa-devel@alsa-project.org, clemens@ladisch.de, jan.baumgart@selma.hfmdk-frankfurt.de
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 04/09/2016 10:43 AM, Takashi Iwai wrote:
> On Fri, 08 Apr 2016 19:52:01 +0200,
> Daniel Mack wrote:
>>
>> UAC2 specifies clock sources that optionally have validity controls.
>> This patch exposes them as mixer controls, so they can be read (and
>> at least in theory even be written) by userspace applications in order
>> to make clock selection policy decisions.
>>
>> This implementation does nothing if the device is not UAC2 compliant,
>> or if the clock source does not define said validity control bits.
>>
>> Tested with a miniDSP USBStreamer (0x2752/0x0016),
>>
>> Signed-off-by: Daniel Mack <daniel@zonque.org>
>> ---
>>  sound/usb/mixer.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 65 insertions(+), 1 deletion(-)
>>
>> diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
>> index 4f85757..973274b 100644
>> --- a/sound/usb/mixer.c
>> +++ b/sound/usb/mixer.c
>> @@ -45,6 +45,7 @@
>>  #include <linux/bitops.h>
>>  #include <linux/init.h>
>>  #include <linux/list.h>
>> +#include <linux/log2.h>
>>  #include <linux/slab.h>
>>  #include <linux/string.h>
>>  #include <linux/usb.h>
>> @@ -1378,6 +1379,68 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
>>  	snd_usb_mixer_add_control(&cval->head, kctl);
>>  }
>>  
>> +static int parse_clock_source_unit(struct mixer_build *state, int unitid,
>> +				   void *_ftr)
>> +
>> +{
>> +	struct uac_clock_source_descriptor *hdr = _ftr;
>> +	struct usb_mixer_elem_info *cval;
>> +	struct snd_kcontrol *kctl;
>> +	char name[100];
> 
> No need for 100.  SNDRV_CTL_ELEM_ID_NAME_MAXLEN should suffice.
> 
>> +	int ret;
>> +
>> +	if (state->mixer->protocol != UAC_VERSION_2)
>> +		return -EINVAL;
>> +
>> +	if (hdr->bLength != sizeof(*hdr))
>> +		return -EINVAL;
> 
> I wonder whether we should abort here and return an error.
> It's a wacky firmware, and no kernel error, after all.

This is what we're doing in other parsers as well, but you're right,
it's better to just add a debug print here and handle this gracefully.

Will send a new patch soon, also addressing the other details.


Thanks,
Daniel
