From: Kailang <kailang@realtek.com>
Subject: Re: audio lost from speaker after reboot from windows
	on the device ALC295
Date: Fri, 5 Jul 2019 02:41:24 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A1D768822@RTITMBSVM07.realtek.com.tw>
References: <CD6925E8781EFD4D8E11882D20FC406D52AB58B6@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 155B3F800E6
 for <alsa-devel@alsa-project.org>; Fri,  5 Jul 2019 04:41:34 +0200 (CEST)
In-Reply-To: <CD6925E8781EFD4D8E11882D20FC406D52AB58B6@SHSMSX104.ccr.corp.intel.com>
Content-Language: zh-TW
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "He, Bo" <bo.he@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "chiu@endlessm.com" <chiu@endlessm.com>, "tiwai@suse.com" <tiwai@suse.com>, "drake@endlessm.com" <drake@endlessm.com>, "hui.wang@canonical.com" <hui.wang@canonical.com>, "jian-hong@endlessm.com" <jian-hong@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Hi Bo He,

Could you help to dump info for us?
Please use attach file to get results.

./alsa-info.sh --no-upload

You will find dump file in folder /tmp/alsa-info.txt-????????.

Please run one time in normal state and one time in fail state.
Please send two result files to me.

BR,
Kailang

> -----Original Message-----
> From: He, Bo <bo.he@intel.com>
> Sent: Thursday, July 4, 2019 8:02 PM
> To: Kailang <kailang@realtek.com>; alsa-devel@alsa-project.org;
> linux-kernel@vger.kernel.org
> Cc: perex@perex.cz; tiwai@suse.com; jian-hong@endlessm.com;
> drake@endlessm.com; chiu@endlessm.com; hui.wang@canonical.com
> Subject: audio lost from speaker after reboot from windows on the device
> ALC295
> 
> Hi, patch_realtek.c maintainer:
> 	I see one issue that reboot from windows and boot to ubuntu, the audio
> lost from speaker, I suspect there are some bugs in patch_realtek.c drivers,
> the device is ALC295 and the device id is 0x10ec0295.
> 
> I have done the below experiments:
> 1. reboot from windows to windows, the audio is persist .
> 2. reboot from windows to ubuntu, the audio lost from speaker, but can hear if
> I hotplug one earphone.
> 3. if the issue reproduce after reboot from windows, reboot the ubuntu can't
> restore the audio, I suspect it's warm reset.
> 4. if I write the port 0xcf9 with 0xe to do cold reset, the audio can restore.
> 5. if I do suspend/resume, the audio can restore, I suspect do cold boot and
> suspend will trigger the platform reset to reset the ALC295.
> 6. if I do double function reset (write the verb 0x7ff in alc_init), the audio is
> still can't restore.
> snd_hda_codec_write(codec, 0x01, 0, AC_VERB_SET_CODEC_RESET, 0); /*
> Function reset */ snd_hda_codec_write(codec, 0x01, 0,
> AC_VERB_SET_CODEC_RESET, 0); /* double Function reset */ 7. the issue is
> first found on kernel 4.19.50, I still see the issue with the latest kernel 5.2-rc2,
> is it possible windows change some default registers, but ALC295 don't
> initialize the register?
> 
> ------Please consider the environment before printing this e-mail.
