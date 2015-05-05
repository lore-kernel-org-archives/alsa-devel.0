From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH] ASoC: Intel: Enabled button jack for BSW
 platform with rt5650 codec
Date: Tue, 5 May 2015 15:02:01 -0700
Message-ID: <CAEUnVG7MW4z4kHipcCWEFAvkqFEu42k4ax4+S2YDvexwJjHdPw@mail.gmail.com>
References: <1430785160-72477-1-git-send-email-yang.a.fang@intel.com>
 <20150505214902.GG15510@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f51.google.com (mail-vn0-f51.google.com
 [209.85.216.51])
 by alsa0.perex.cz (Postfix) with ESMTP id A26B92604A3
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 00:02:23 +0200 (CEST)
Received: by vnbf62 with SMTP id f62so18118813vnb.3
 for <alsa-devel@alsa-project.org>; Tue, 05 May 2015 15:02:22 -0700 (PDT)
In-Reply-To: <20150505214902.GG15510@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, srinivas.sripathi@intel.com, Yang Fang <yang.a.fang@intel.com>, Praveen K Jain <praveen.k.jain@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vinod.koul@intel.com>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>, Denny Iriawan <denny.iriawan@intel.com>, kevin.strasser@linux.intel.com
List-Id: alsa-devel@alsa-project.org

On Tue, May 5, 2015 at 2:49 PM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, May 04, 2015 at 05:19:20PM -0700, yang.a.fang@intel.com wrote:
>> From: "Fang, Yang A" <yang.a.fang@intel.com>
>>
>> rt5650 codec supports 4 buttons detections so enabled it
>
>> @@ -43,6 +43,7 @@ struct cht_acpi_card {
>>  struct cht_mc_private {
>>       struct snd_soc_jack hp_jack;
>>       struct snd_soc_jack mic_jack;
>> +     struct snd_soc_jack btn_jack;
>>       struct cht_acpi_card *acpi_card;
>
> This is a bit weird - why are we adding an additional jack here, surely
> the button is attached to the mic jack here?  The jacks should
> correspond to the physical jacks on the system rather than the function
> so that users and applications can tie the jacks that we have in
> software to those physically on the system.
>
> Now I'm wondering if the headphone and microphone are expected to be a
> single jack here?

At least the Chromebook version will have a single combo jack.  I
would expect there to be a single jack created that reports all of hp,
mic, and buttons.

>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
