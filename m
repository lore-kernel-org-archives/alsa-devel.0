From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] ALSA: HDA: Cirrus - fix "Surround Speaker"
 volume control, name
Date: Wed, 14 Sep 2011 13:38:58 +0200
Message-ID: <4E709252.5060206@canonical.com>
References: <4E708F43.9060302@canonical.com> <s5hvcsvs6em.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 16808243DF
	for <alsa-devel@alsa-project.org>;
	Wed, 14 Sep 2011 13:39:02 +0200 (CEST)
In-Reply-To: <s5hvcsvs6em.wl%tiwai@suse.de>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Arun Raghavan <arun.raghavan@collabora.co.uk>
List-Id: alsa-devel@alsa-project.org

On 09/14/2011 01:35 PM, Takashi Iwai wrote:
> At Wed, 14 Sep 2011 13:25:55 +0200,
> David Henningsson wrote:
>>
>> > From 7d63b3c06a02d107d9f499c43d6396ada9caae98 Mon Sep 17 00:00:00 2001
>> From: David Henningsson<david.henningsson@canonical.com>
>> Date: Wed, 14 Sep 2011 13:22:54 +0200
>> Subject: [PATCH] ALSA: HDA: Cirrus - fix "Surround Speaker" volume control
>>   name
>>
>> Commit b4dabfc452a10 fixed only the "Switch" name, not the "Volume" name.
>>
>> Signed-off-by: David Henningsson<david.henningsson@canonical.com>
>> ---
>>   sound/pci/hda/patch_cirrus.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
>> index d6c93d9..c45f3e6 100644
>> --- a/sound/pci/hda/patch_cirrus.c
>> +++ b/sound/pci/hda/patch_cirrus.c
>> @@ -535,7 +535,7 @@ static int add_volume(struct hda_codec *codec, const char *name,
>>   		      int index, unsigned int pval, int dir,
>>   		      struct snd_kcontrol **kctlp)
>>   {
>> -	char tmp[32];
>> +	char tmp[44];
>>   	struct snd_kcontrol_new knew =
>>   		HDA_CODEC_VOLUME_IDX(tmp, index, 0, 0, HDA_OUTPUT);
>>   	knew.private_value = pval;
>
> Hm, it doesn't match with the patch description...

Sorry, can you clarify what I have to do to get this patch committed?

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
