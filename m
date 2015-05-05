From: Dylan Reid <dgreid@chromium.org>
Subject: Re: [PATCH] ASoC: Intel: Enabled button jack for BSW
 platform with rt5650 codec
Date: Tue, 5 May 2015 15:42:52 -0700
Message-ID: <CAEUnVG5Kcht5wV-o1d+o4D3z0q-Xau1XSQ58_W=xWyUZHGQi1w@mail.gmail.com>
References: <1430785160-72477-1-git-send-email-yang.a.fang@intel.com>
 <20150505214902.GG15510@sirena.org.uk>
 <CAEUnVG7MW4z4kHipcCWEFAvkqFEu42k4ax4+S2YDvexwJjHdPw@mail.gmail.com>
 <20150505221415.GA109322@mocha> <20150505223028.GK15510@sirena.org.uk>
 <0485FB02182A4744A8B06D69AB7BF8E718CCC12F@ORSMSX113.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f43.google.com (mail-vn0-f43.google.com
 [209.85.216.43])
 by alsa0.perex.cz (Postfix) with ESMTP id E3F392604A7
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2015 00:43:13 +0200 (CEST)
Received: by vnbf129 with SMTP id f129so18165293vnb.9
 for <alsa-devel@alsa-project.org>; Tue, 05 May 2015 15:43:12 -0700 (PDT)
In-Reply-To: <0485FB02182A4744A8B06D69AB7BF8E718CCC12F@ORSMSX113.amr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Fang, Yang A" <yang.a.fang@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Sripathi,
 Srinivas" <srinivas.sripathi@intel.com>, "Koul, Vinod" <vinod.koul@intel.com>, "Jain, Praveen K" <praveen.k.jain@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, "Iriawan,
 Denny" <denny.iriawan@intel.com>, Mark Brown <broonie@kernel.org>, "Nujella,
 Sathyanarayana" <sathyanarayana.nujella@intel.com>, Bard Liao <bardliao@realtek.com>, "kevin.strasser@linux.intel.com" <kevin.strasser@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Tue, May 5, 2015 at 3:39 PM, Fang, Yang A <yang.a.fang@intel.com> wrote:
>
>
>> -----Original Message-----
>> From: Mark Brown [mailto:broonie@kernel.org]
>> Sent: Tuesday, May 05, 2015 3:30 PM
>> To: Fang, Yang A
>> Cc: Dylan Reid; alsa-devel@alsa-project.org; Sripathi, Srinivas; Koul, Vinod;
>> Jain, Praveen K; Liam Girdwood; Iriawan, Denny; Nujella, Sathyanarayana;
>> kevin.strasser@linux.intel.com
>> Subject: Re: [alsa-devel] [PATCH] ASoC: Intel: Enabled button jack for BSW
>> platform with rt5650 codec
>>
>> On Tue, May 05, 2015 at 03:14:15PM -0700, Yang Fang wrote:
>>
>> > now rt5645_set_jack_detect in rt5645.c aleady split jack into 3 like
>> > below. maybe we need Bard to combine them ?
>>
>> It's fine to do that in the CODEC driver and actually good for the headphone
>> and microphone - the board can always pass in the same jack for all of them
>> but if it does have split headphone and mic jacks then it can do that.
>
> Thanks. I will post v2 after Bard modifies the api

If I'm interpreting Mark's comment correctly, he is suggesting that
the API remain the same and have cht_bsw_rt5645.c pass the same jack
to all three parameters.  I like this idea, as unlike the 227e driver
the 5650 could be used with separate hp and mic jacks. I'd imagine
there wouldn't be a button jack in that case since that is headset
specific, but that shouldn't matter.

>
> Yang
