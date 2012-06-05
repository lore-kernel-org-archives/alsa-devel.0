From: Wang Xingchao <wangxingchao2011@gmail.com>
Subject: Re: [PATCH] ALSA: hda - add power states information
	in proc
Date: Wed, 6 Jun 2012 06:11:19 +0800
Message-ID: <CA+v+29j7GiC9eH_v2gDXADzwN1DDPR0SkgOuRNPVVEytd6fXJQ@mail.gmail.com>
References: <1338890890-25147-1-git-send-email-xingchao.wang@intel.com>
	<s5h62b5wyhh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E0C641043A6
	for <alsa-devel@alsa-project.org>;
	Wed,  6 Jun 2012 00:11:40 +0200 (CEST)
Received: by vbip1 with SMTP id p1so3562476vbi.38
	for <alsa-devel@alsa-project.org>; Tue, 05 Jun 2012 15:11:39 -0700 (PDT)
In-Reply-To: <s5h62b5wyhh.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, swarren@nvidia.com, Wang Xingchao <xingchao.wang@intel.com>
List-Id: alsa-devel@alsa-project.org

2012/6/5 Takashi Iwai <tiwai@suse.de>:
> At Tue, =A05 Jun 2012 18:08:10 +0800,
> Wang Xingchao wrote:
>>
>> add more power states information:
>> - reset status
>> - clock stop ok
>> - power states error
>>
>> Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
>> ---
>> =A0sound/pci/hda/hda_codec.h | =A0 =A03 +++
>> =A0sound/pci/hda/hda_proc.c =A0| =A0 =A06 ++++++
>> =A02 files changed, 9 insertions(+)
>>
>> diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
>> index 4fc3960..71864cdd 100644
>> --- a/sound/pci/hda/hda_codec.h
>> +++ b/sound/pci/hda/hda_codec.h
>> @@ -323,6 +323,9 @@ enum {
>> =A0#define AC_PWRST_D1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x01
>> =A0#define AC_PWRST_D2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x02
>> =A0#define AC_PWRST_D3 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x03
>> +#define AC_PWRST_ERROR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1<<8)
>> +#define AC_PWRST_CLK_STOP_OK =A0 =A0 =A0 =A0 =A0 =A0(1<<9)
>> +#define AC_PWRST_SETTING_RESET =A0 =A0 =A0 =A0 =A0(1<<10)
>>
>> =A0/* Processing capabilies */
>> =A0#define AC_PCAP_BENIGN =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (1=
<<0)
>> diff --git a/sound/pci/hda/hda_proc.c b/sound/pci/hda/hda_proc.c
>> index e59e2f0..5511de1 100644
>> --- a/sound/pci/hda/hda_proc.c
>> +++ b/sound/pci/hda/hda_proc.c
>> @@ -459,6 +459,12 @@ static void print_power_state(struct snd_info_buffe=
r *buffer,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_pwr_state(pwr & AC_PWRST_SETTING=
),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 get_pwr_state((pwr & AC_PWRST_ACTUAL=
) >>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AC_PWRST=
_ACTUAL_SHIFT));
>> + =A0 =A0 if (pwr & AC_PWRST_ERROR)
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_iprintf(buffer, " Power state error\n");
>> + =A0 =A0 if (pwr & AC_PWRST_CLK_STOP_OK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_iprintf(buffer, " PS: clock stop ok\n");
>> + =A0 =A0 if (pwr & AC_PWRST_SETTING_RESET)
>> + =A0 =A0 =A0 =A0 =A0 =A0 snd_iprintf(buffer, " Power state setting rese=
t\n");
>
> I prefer keeping the format like "AAA: BBB".
> Or, can these extra bits be appended "Power:" line, such as
>
> =A0 Power: setting=3DD0, actual=3DD0, Error, Clock-stop-OK, Setting-reset
>

Sure, thanks for your review, i will send out second version patch later.

thanks
--xingchao
