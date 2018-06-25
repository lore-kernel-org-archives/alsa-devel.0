From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [[PATCH 0/9] ASoC: Intel: bytcr_rt5651: Cleanup
 (input mapping quirks)
Date: Mon, 25 Jun 2018 15:01:53 -0500
Message-ID: <4aba171d-0aea-cfad-410c-3fcd0bed3609@linux.intel.com>
References: <20180624140634.16835-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by alsa0.perex.cz (Postfix) with ESMTP id 64B6F2673F5
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 03:22:05 +0200 (CEST)
In-Reply-To: <20180624140634.16835-1-hdegoede@redhat.com>
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
To: Hans de Goede <hdegoede@redhat.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>
Cc: alsa-devel@alsa-project.org, Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On 6/24/18 9:06 AM, Hans de Goede wrote:
> Hi Mark,
> 
> This series is mainly a cleanup series. In the beginning of the rt5651
> machine driver some wrong assumptions were made, such as the headset
> mic being attached to IN2 (it is on IN3 on the 7 machines I have access
> to and on all otherwise known machines).

We use a rt5651 reference board for this codec connector to the 
MinnowBoard. I am pretty sure for that board IN2 is used for the 
headset. Please give me a couple of days to double-check.

> 
> And also adding a quirk for a machine with the intmic on IN2, which
> later got fixed with a new quirk for machines with 2 internal mics
> on both IN1 and IN2 and moving the one machine with the IN2 quirk
> over to the new IN1_IN2 quirk, leaving the IN2 quirk as an orphan
> quirk for non existing hardware.
> 
> Then I made a similar mistake adding the IN2_HS_IN3 quirk, while I
> should have used the IN1_HS_IN3 (which itself only exists because
> the original IN1 quirk has the headset input mapping wrong),
> 
> TL;DR: it is a bit of a mess due to a number of wrong assumptions
> about how the inputs where actually routed in the past.
> 
> This series cleans this all up in small commits / one bit a time and
> refers the original commit messages in its commit messages.
> 
> Note patch 10/11 is not a cleanup patch, but is more or less the
> reason I took a second look at all the quirks.
> 
> Regards,
> 
> Hans
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
