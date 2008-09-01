From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: Distortion fix for dell_m6_core_init
Date: Mon, 01 Sep 2008 09:51:28 -0400
Message-ID: <48BBF360.4020908@embeddedalley.com>
References: <48BAE8B2.4020204@embeddedalley.com> <s5h4p5074ln.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.124]) by alsa0.perex.cz (Postfix) with ESMTP id E68452440E
	for <alsa-devel@alsa-project.org>;
	Mon,  1 Sep 2008 15:51:31 +0200 (CEST)
In-Reply-To: <s5h4p5074ln.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Sun, 31 Aug 2008 14:53:38 -0400,
> Matthew Ranostay wrote:
>> Added the EQ distortion fix to the dell_m6_core_init.
>>
>> ---
>> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
> 
> Thanks.  I'll include this as 2.6.27 fixes, too.
> 
> BTW, I found the volume-knob on 0x1f is set to 0xff with other models
> (e.g. intel boards).  Don't you need to fix them as well? 
> 
Nope, they don't have this issue.


> 
> Takashi
> 
>> diff --git a/pci/hda/patch_sigmatel.c b/pci/hda/patch_sigmatel.c
>> index 6ad6ef3..9968ee4 100644
>> --- a/pci/hda/patch_sigmatel.c
>> +++ b/pci/hda/patch_sigmatel.c
>> @@ -606,8 +606,9 @@ static struct hda_verb dell_eq_core_init[] = {
>>  };
>>
>>  static struct hda_verb dell_m6_core_init[] = {
>> -	/* set master volume and direct control */
>> -	{ 0x1f, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xff},
>> +	/* set master volume to max value without distortion
>> +	 * and direct control */
>> +	{ 0x1f, AC_VERB_SET_VOLUME_KNOB_CONTROL, 0xec},
>>  	/* setup audio connections */
>>  	{ 0x0d, AC_VERB_SET_CONNECT_SEL, 0x00},
>>  	{ 0x0a, AC_VERB_SET_CONNECT_SEL, 0x01},
>>
> 
