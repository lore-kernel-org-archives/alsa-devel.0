From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH - alsa-lib] tlv: Check dB range only within
 the control's volume range
Date: Wed, 19 May 2010 12:42:03 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1005191239530.6856@eeebox2.perex-int.cz>
References: <1274249966-31030-1-git-send-email-peter.ujfalusi@nokia.com>
	<alpine.LNX.2.00.1005190854200.6856@eeebox2.perex-int.cz>
	<201005191028.55258.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id EAF40245E2
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 12:42:05 +0200 (CEST)
In-Reply-To: <201005191028.55258.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 19 May 2010, Peter Ujfalusi wrote:

> On Wednesday 19 May 2010 09:55:40 ext Jaroslav Kysela wrote:
>> On Wed, 19 May 2010, Peter Ujfalusi wrote:
>>> The DB_RANGE need to be used on some HW, since the gain on
>>> volume control is not continuous, and has to be divided into
>>> several sub DB_SCALE ranges.
>>> ASoC has a feature to override the HW default volume range,
>>> and in this case when the volume range is less than the
>>> HW maximum we do not need to go through the whole DB_RANGE,
>>> but we need to stop where the kcontrol's maximum tell us.
>>>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
>>
>> Unfortunately, it does not look like a clean way in my eyes. If the driver
>> pushes some limits to the control (volume) range, it should do it also
>> for TLVs.
>
> My thinking was that the snd_tlv_get_dB_range SNDRV_CTL_TLVT_DB_RANGE case
> should obey the control's range provided by the driver, similarly how the
> SNDRV_CTL_TLVT_DB_SCALE is using the rangemax, rangemin.
> In case of SNDRV_CTL_TLVT_DB_RANGE, we should not go beyond the control's
> rangemax.
>
> In this way both of the following volume control is going to be handled
> correctly:
>
> 1.
> static DECLARE_TLV_DB_SCALE(dac_digivol_tlv, -6350, 50, 0);
>
> static const struct snd_kcontrol_new dac33_snd_controls[] = {
> 	SOC_DOUBLE_R_TLV("DAC Digital Playback Volume",
> 		DAC33_LDAC_DIG_VOL_CTRL, DAC33_RDAC_DIG_VOL_CTRL,
> 		0, 0x7f, 1, dac_digivol_tlv),
> };
>
> Original range (127): -63.5 .. 0 dB
> Limited range  (100): -63.5 .. -13.5 dB
>
> 2.
> static const unsigned int tpa6140_tlv[] = {
> 	TLV_DB_RANGE_HEAD(3),
> 	0, 8, TLV_DB_SCALE_ITEM(-5900, 400, 0),
> 	9, 16, TLV_DB_SCALE_ITEM(-2500, 200, 0),
> 	17, 31, TLV_DB_SCALE_ITEM(-1000, 100, 0),
> };
>
> static const struct snd_kcontrol_new tpa6140a2_controls[] = {
> 	SOC_SINGLE_EXT_TLV("TPA6140A2 Headphone Playback Volume",
> 		       TPA6130A2_REG_VOL_MUTE, 1, 0x1f, 0,
> 		       tpa6130a2_get_volsw, tpa6130a2_put_volsw,
> 		       tpa6140_tlv),
> };
>
> Original range (31): -59 .. 4 dB
> Limited range  (21): -59 .. -6 dB
> Limited range  (16): -59 .. -11 dB
>
> In case of DB_SCALE in theory the maximum gain depends on the maximum volume
> possible on the control.
> When the gain is not linear, it has to divided into sub DB_SCALE sections to get
> accurate mapping.
> Now, if the kernel code for the limiting has to do more than changing the
> maximum volume, than it means that it _has_ to rewrite the TLV table in a clever
> way, or provide a new one which fits with the limited volume.
> Rewriting the TLV table taking into account all possible cases is not that safe,
> and I'm sure there could be still some corners, where it would fail.
>
> I think the patch provides uniform, and error prone way of handling this
> situation, while not breaking any existing parts.

I forgot that we carry the control value ranges in the DB_RANGE 
container. I applied your patch to alsa-lib's GIT tree. Thanks for it and 
for your detailed analysis.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
