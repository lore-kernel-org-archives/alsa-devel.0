From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [[PATCH 0/9] ASoC: Intel: bytcr_rt5651: Cleanup
 (input mapping quirks)
Date: Tue, 26 Jun 2018 11:47:10 +0200
Message-ID: <d383ab37-9055-79f5-21a1-78308fb1d48d@redhat.com>
References: <20180624140634.16835-1-hdegoede@redhat.com>
 <4aba171d-0aea-cfad-410c-3fcd0bed3609@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 562282675C8
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 11:47:12 +0200 (CEST)
Received: by mail-ed1-f68.google.com with SMTP id l23-v6so604214edq.0
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 02:47:12 -0700 (PDT)
In-Reply-To: <4aba171d-0aea-cfad-410c-3fcd0bed3609@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 25-06-18 22:01, Pierre-Louis Bossart wrote:
> On 6/24/18 9:06 AM, Hans de Goede wrote:
>> Hi Mark,
>>
>> This series is mainly a cleanup series. In the beginning of the rt5651
>> machine driver some wrong assumptions were made, such as the headset
>> mic being attached to IN2 (it is on IN3 on the 7 machines I have access
>> to and on all otherwise known machines).
> 
> We use a rt5651 reference board for this codec connector to the MinnowBoard. I am pretty sure for that board IN2 is used for the headset. Please give me a couple of days to double-check.

According to this commit:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/intel/boards/bytcr_rt5651.c?id=60e3b52e9354550c28090237b083b20bbabed598

It is connected to IN3 on the Minnowboard Max with Realtek rt5651 eval board.

And you yourself added a quirk for it being on IN3 for the MinnowBoard Turbot:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/intel/boards/bytcr_rt5651.c?id=416f2b51119b8cdd899b226e4cf683d000797a8b

Note I later renamed the IN3_MAP to IN1_HS_IN3 to make clear that it
is for internal mic on IN1, hs-mis on IN3, as can be seen in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/sound/soc/intel/boards/bytcr_rt5651.c?id=60e3b52e9354550c28090237b083b20bbabed598
(which is the commit adding both the quirk and updating the Minnowboard Max
  DMI entry to use this quirk).

Regards,

Hans



>> And also adding a quirk for a machine with the intmic on IN2, which
>> later got fixed with a new quirk for machines with 2 internal mics
>> on both IN1 and IN2 and moving the one machine with the IN2 quirk
>> over to the new IN1_IN2 quirk, leaving the IN2 quirk as an orphan
>> quirk for non existing hardware.
>>
>> Then I made a similar mistake adding the IN2_HS_IN3 quirk, while I
>> should have used the IN1_HS_IN3 (which itself only exists because
>> the original IN1 quirk has the headset input mapping wrong),
>>
>> TL;DR: it is a bit of a mess due to a number of wrong assumptions
>> about how the inputs where actually routed in the past.
>>
>> This series cleans this all up in small commits / one bit a time and
>> refers the original commit messages in its commit messages.
>>
>> Note patch 10/11 is not a cleanup patch, but is more or less the
>> reason I took a second look at all the quirks.
>>
>> Regards,
>>
>> Hans
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>>
> 
