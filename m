From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH - [hdspm] RayDAT/AIO 1/2] ALSA: Add support
 for RME RayDAT and AIO
Date: Thu, 27 Jan 2011 09:09:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1101270905430.6272@eeebox2.perex-int.cz>
References: <1296066735-11280-1-git-send-email-adi@drcomp.erfurt.thur.de>
	<1296066735-11280-2-git-send-email-adi@drcomp.erfurt.thur.de>
	<s5htygudb6e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A51C9103A7E
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 09:09:07 +0100 (CET)
In-Reply-To: <s5htygudb6e.wl%tiwai@suse.de>
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
Cc: Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 27 Jan 2011, Takashi Iwai wrote:

> At Wed, 26 Jan 2011 19:32:14 +0100,
> Adrian Knoth wrote:
>>
>> diff --git a/include/sound/hdspm.h b/include/sound/hdspm.h
>> index 81990b2..c3f1819 100644
>> --- a/include/sound/hdspm.h
>> +++ b/include/sound/hdspm.h
>> @@ -131,4 +225,175 @@ typedef struct hdspm_version hdspm_version_t;
>>  typedef struct hdspm_channelfader snd_hdspm_channelfader_t;
>>  typedef struct hdspm_mixer hdspm_mixer_t;
>>
>> -#endif				/* __SOUND_HDSPM_H */
>> +/* These tables map the ALSA channels 1..N to the channels that we
>> +   need to use in order to find the relevant channel buffer. RME
>> +   refers to this kind of mapping as between "the ADAT channel and
>> +   the DMA channel." We index it using the logical audio channel,
>> +   and the value is the DMA channel (i.e. channel buffer number)
>> +   where the data for that channel can be read/written from/to.
>> +*/
>> +
>> +char channel_map_unity_ss[HDSPM_MAX_CHANNELS] = {
>
> Err, no, array definitions should be never in a header file.
> It doesn't matter whether it's static or not.  The definition should
> be in *.c file where it's used.
>
> So, simply move these array definitions to hdspm.c.

I think that the reason is to share these arrays with hdspmixer.
But I agree, that it's better to move these static values to .c files.

Note that hdsm/hdspmixer issues are last ones to resolve before 1.0.24 
release. I am waiting for the driver update.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
