From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: STAC927x analog mic
Date: Thu, 21 Feb 2008 07:42:55 -0500
Message-ID: <0626BD7E-1419-4FD8-A353-6969A69DDC8D@embeddedalley.com>
References: <47BCE6D7.7000205@embeddedalley.com> <s5hd4qqss3g.wl%tiwai@suse.de>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp100.biz.mail.re2.yahoo.com (smtp100.biz.mail.re2.yahoo.com
	[206.190.52.46]) by alsa0.perex.cz (Postfix) with SMTP id A80652440A
	for <alsa-devel@alsa-project.org>; Thu, 21 Feb 2008 13:42:58 +0100 (CET)
In-Reply-To: <s5hd4qqss3g.wl%tiwai@suse.de>
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


On Feb 21, 2008, at 2:09 AM, Takashi Iwai wrote:

> At Wed, 20 Feb 2008 21:49:59 -0500,
> Matthew Ranostay wrote:
>>
>> Some laptops have a internal analog microphone that is not setup  
>> by the BIOS.
>>
>> Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>
>
> Applied to HG tree.
>
> BTW, are there boards / machines that have both analog and digital
> mics?
Yep there are several boards that have both analog and digital mics.

> Currently, we have "Digital Capture Volume".  It was introduced
> as an alternative volume control for digital mics.  But, this seems
> confusing people a lot because this volume works correctly at 50%,
> corresponding to 0dB.  For systems that have only analog mics, this
> control doesn't make much sense.
>
> Thus, I would love to make this control depending on the presence of
> digital mic if possible...
>
>
> thanks,
>
> Takashi
>
>> ---
>> diff -r 6b53fa114faa pci/hda/patch_sigmatel.c
>> --- a/pci/hda/patch_sigmatel.c	Tue Feb 19 15:03:57 2008 +0100
>> +++ b/pci/hda/patch_sigmatel.c	Wed Feb 20 17:11:51 2008 -0500
>> @@ -3629,6 +3629,8 @@ static int patch_stac927x(struct hda_cod
>>  		spec->mixer = stac927x_mixer;
>>  		break;
>>  	case STAC_DELL_BIOS:
>> +		/* configure the analog microphone on some laptops */
>> +		stac92xx_set_config_reg(codec, 0x0c, 0x90a79130);
>>  		/* correct the front output jack as a hp out */
>>  		stac92xx_set_config_reg(codec, 0x0f, 0x02270110);
>>  		/* correct the front input jack as a mic */
>>
>
