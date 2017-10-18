From: Carlo Caione <carlo@endlessm.com>
Subject: Re: [PATCH 0/2] rt5651: Enable platforms with int mic
	on IN2
Date: Wed, 18 Oct 2017 17:35:28 +0100
Message-ID: <CAL9uMOHgh09W_T_zk4ki=a8f1VoHJxzWKtq=JJPYyOgtGPz+RA@mail.gmail.com>
References: <20171018160759.18563-1-carlo@caione.org>
 <2511be5d-4885-85a8-7bdb-a67421b81538@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f67.google.com (mail-vk0-f67.google.com
 [209.85.213.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DCD2266EE0
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 18:35:30 +0200 (CEST)
Received: by mail-vk0-f67.google.com with SMTP id g11so479685vkd.13
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 09:35:30 -0700 (PDT)
In-Reply-To: <2511be5d-4885-85a8-7bdb-a67421b81538@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@caione.org>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 18, 2017 at 5:19 PM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 10/18/17 11:07 AM, Carlo Caione wrote:
>>
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> While working on enabling a cherry-trail laptop shipping the rt5651
>> codec I realized that the machine driver needed some fixup.
>>
>> In particular the laptop I'm working on (KIANO SlimNote 14.2) has the
>> internal mic connected to the IN2 port.
>>
>> All the laptop-specific work with the related quirks will follow.
>
>
> Nice, thanks for the work. You'll have to rebase and resubmit to fix
> conflicts. I provided changes to simplify DMIC quirks (there is a single
> interface, not 2 on this chip) that aren't reflected in your patches and the
> addition of MCLK support. Mark's for-next branch already took the changes
> this morning.

Ups, missed that for a few hours. I'll prepare a new PR.

> Also let me know if you want the UCM files to be updated.

I have a UCM file already that seems to work fine on this laptop. I'll
prepare a PR also for that once all the kernel pieces are in place.

Thank you,

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
