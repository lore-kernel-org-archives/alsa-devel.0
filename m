From: Kailang <kailang@realtek.com>
Subject: Re: Dell AIO speaker pop noise
Date: Tue, 16 Apr 2019 08:59:37 +0000
Message-ID: <6FAB7C47BCF00940BB0999A99BE3547A18DBBC48@RTITMBSVM07.realtek.com.tw>
References: <6FAB7C47BCF00940BB0999A99BE3547A18DBBB6E@RTITMBSVM07.realtek.com.tw>
 <bc45619b-951a-f2c5-5b3c-9a51a21708f2@perex.cz>
 <s5h8swajr70.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9189F89614
 for <alsa-devel@alsa-project.org>; Tue, 16 Apr 2019 10:59:44 +0200 (CEST)
In-Reply-To: <s5h8swajr70.wl-tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>
Cc: hwang4 <hui.wang@canonical.com>, "(alsa-devel@alsa-project.org)" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: Takashi Iwai <tiwai@suse.de>
> Sent: Tuesday, April 16, 2019 4:22 PM
> To: Jaroslav Kysela <perex@perex.cz>
> Cc: Kailang <kailang@realtek.com>; hwang4 <hui.wang@canonical.com>;
> (alsa-devel@alsa-project.org) <alsa-devel@alsa-project.org>
> Subject: Re: [alsa-devel] Dell AIO speaker pop noise
> 
> On Tue, 16 Apr 2019 10:01:31 +0200,
> Jaroslav Kysela wrote:
> >
> > Dne 16. 04. 19 v 9:30 Kailang napsal(a):
> > > Hi Takashi,
> > >
> > > Issue 1: The noise keeps occurring via speaker when Headset is plugged in.
> > > Issue 2: The humming noise is occuring when switching to sound of
> settings.
> > > 	 The noise will be stopped when switching to other options of settings.
> > > Issue 3: The popping noise occurred for one second when plugged in and
> removed the headset.
> > >
> > > This patch will solve this three issues.
> >
> > Hi,
> >
> >   could you explain, why the power-save function causes this
> > behaviour? Can we do something else than turning off the power-save
> > codec settings to avoid such noises? I have this question because it's really
> easy to disable something, but I feel that the culprit of the noises might be just
> the wrong codec settings. I guess that you have probably full documentation
> for the codec and probably for the hardware, so it might be nice to find the
> real culprit.
> 
> Note that power_save_node=0 doesn't mean that the whole power saving is
> disabled.  It disables the fine-grained power saving, i.e. powering down the
> unused widget nodes.
> 
> If so, I wonder whether this might be about the default pin-shutup behavior.  I
> improved the click noise problem on my Dell desktop by disabling the pin
> shutup.  See commit c0ca5eced222.
> Kailang, Hui, did you try to add the chain to ALC269_FIXUP_NO_SHUTUP?
> 
This noise was not happen on poweroff.
AIO use external AMP. So, it will be need to have a reference voltage via codec.
So, Pin-ctls was not be 0. I apply option spec->gen.suppress_auto_mute = 1 to avoid that. 
Internal SPK PIN also don't enter to D3. But I find it just only happen on ALC274 family codecs.
ALC274 pin enter to D3. Pin-ctls also be 0. So, power_save_node=0 will let PIN to D0.

power_save = 0 it also could solve issue.



> 
> thanks,
> 
> Takashi
> 
> ------Please consider the environment before printing this e-mail.
