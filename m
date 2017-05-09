From: Paulo Sergio <pstglia@gmail.com>
Subject: Re: WM5102 - Help to make baytrail machine driver work
Date: Tue, 9 May 2017 11:45:52 -0300
Message-ID: <CAJcYhpb9yOJjDwG6ZGEYFQTiLXtkHNgmVkmF2ssQp6QPOX0ueA@mail.gmail.com>
References: <CAJcYhpZU-6_AO_Gye1VttuvOP0Z2=wLuWGCOP7tBWc6DsuLU1g@mail.gmail.com>
 <20160505091122.GE1646@localhost.localdomain>
 <CAJcYhpbdr-3qBSdaLX-=MCSGX7VC0XGz6tKbzJ3K3RHeGMhs7g@mail.gmail.com>
 <CAJcYhpZ1NRUa_7nu5kT6yJ_NTbDxRtK5Uy0H1fxMBEHhvA1fxw@mail.gmail.com>
 <20160509142210.GH1646@localhost.localdomain>
 <CAJcYhpa8OrxyFxL1L4VQJL=WSEhrKhvfcdLeUj40Hb=N2kDUUQ@mail.gmail.com>
 <20160513114136.GM1646@localhost.localdomain>
 <CAJcYhpYJcTE0qBwYAHtGF9tbNCKXAVaLP3RnS5CF5=Z1LBijmA@mail.gmail.com>
 <20160515101308.GN1646@localhost.localdomain>
 <CAJcYhpaFiDrMYmbS1cUWL=ix-L2crjnNekpCXjjdHVThwp2Xag@mail.gmail.com>
 <20170508082422.GJ1594@localhost.localdomain>
 <CAJcYhpb0amzyug01nN3TUWBFSgGWfZcfOVfMgV01rxgTnbNnHg@mail.gmail.com>
 <7c35cd21-35a4-726d-71b5-1ef9f096fbee@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f52.google.com (mail-pg0-f52.google.com [74.125.83.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 992D2266483
 for <alsa-devel@alsa-project.org>; Tue,  9 May 2017 16:45:54 +0200 (CEST)
Received: by mail-pg0-f52.google.com with SMTP id u28so805846pgn.1
 for <alsa-devel@alsa-project.org>; Tue, 09 May 2017 07:45:54 -0700 (PDT)
In-Reply-To: <7c35cd21-35a4-726d-71b5-1ef9f096fbee@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: vinod.koul@intel.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, broonie@opensource.wolfsonmicro.com, mika.westerberg@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>>> How are you setting up the I2S? As in which side is master, what
>>> format are you using? Also do you see any over/underflow error,
>>> does the system complain with "Error playing sample".
>>
>>
>> The only part where I2S is explicity used on machine driver is this
>> setting on backend DAI (SSP0-Codec)
>>
>> dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
>> | SND_SOC_DAIFMT_CBS_CFS,
>>
>> And after setting the routes using routes mentioned on [3], I have no
>> errors, but no sound
>>
>> Note: Based on Lenovo code, I concluded this device uses ssp0, so I'm
>> using a fw file "fw_sst_0f28_ssp0.bin" posted another thread.
>> Could use the hacks used on kernel 4.11, but as I'm still testing with
>> kernel 4.4, using this fw would make things easier
>
>
> nope. I don't know how many issues we've fixed since 4.4 but it's not a
> matter of just swapping out one firmware with another. You'll have better
> luck with plain vanilla 4.11 + regular firmware and restarting modifying one
> of the latest machine drivers.

Ok, I'll use 4.11 and post the results later

Should I have any special care about I2S other than setting the format
um backend DAI?
Some module should be loaded?

Regards
Pstglia
