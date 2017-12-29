From: Bard Liao <bardliao@realtek.com>
Subject: Re: Cherry Trail + RT5645 devices analog microphone
	not working.
Date: Fri, 29 Dec 2017 02:10:20 +0000
Message-ID: <ABFD875FF5FB574BA706497D987D48D70274F5AB@RTITMBSV02.realtek.com.tw>
References: <d42279d7-0350-563f-fca7-27f32cb9e9ee@redhat.com>
 <ABFD875FF5FB574BA706497D987D48D7027476BE@RTITMBSV02.realtek.com.tw>
 <6ccb2c4c-042f-46c0-5247-90f79d49c840@redhat.com>
 <ABFD875FF5FB574BA706497D987D48D70274A822@RTITMBSV02.realtek.com.tw>
 <a0540986-369c-5bca-424f-102391d85095@redhat.com>
 <ABFD875FF5FB574BA706497D987D48D70274DD33@RTITMBSV02.realtek.com.tw>
 <7dcc5148-dd01-ddbb-516b-51ffd4f1c31a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 by alsa0.perex.cz (Postfix) with ESMTP id 12B4726720C
 for <alsa-devel@alsa-project.org>; Fri, 29 Dec 2017 03:10:27 +0100 (CET)
In-Reply-To: <7dcc5148-dd01-ddbb-516b-51ffd4f1c31a@redhat.com>
Content-Language: zh-TW
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

> Some questions for you:
> 
> 1) I think enabling micbias2 may be a problem on devices with a DMIC,
> could this be a problem?  Currently the codec driver itself contains
> quirks for dmic pin-mapping, maybe we should leave micbias2 disabled
> if dmic pin-mapping is specified through a quirk?

No, micbias2 and DMIC are independent and micbias2 will not be enabled
if we don't add it in the audio route. So I don't think we need to disable it
if dmic pin-mapping is specified.

> 
> 2) Do headset mics normally need a bias current? Could this be headset
> dependent?

Yes, but we don't need to set specific register for that. It means you don't
need to add "micbias1" in the audio route for headset mic.
I think all headset mic will need a bias current.

> 
> Regards,
> 
> Hans
> 
