From: Carlo Caione <carlo@caione.org>
Subject: Re: [PATCH] SoC: intel: byt: Introduce new custom IN2
	map
Date: Thu, 16 Nov 2017 13:53:58 +0000
Message-ID: <CAOQ7t2YFfkCEkgoGPspr8Kvuomz-eeprqC6NJXiUhDApFqbduA@mail.gmail.com>
References: <20171018164957.2270-1-carlo@caione.org>
 <b09a704c-bb3e-32c4-afcb-d11379b6a3b9@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f65.google.com (mail-pg0-f65.google.com [74.125.83.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C40A26710A
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 14:54:00 +0100 (CET)
Received: by mail-pg0-f65.google.com with SMTP id u3so5489514pgn.7
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 05:54:00 -0800 (PST)
In-Reply-To: <b09a704c-bb3e-32c4-afcb-d11379b6a3b9@linux.intel.com>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, open list <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@endlessm.com>, Carlo Caione <carlo@caione.org>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Oct 18, 2017 at 7:05 PM, Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> On 10/18/17 11:49 AM, Carlo Caione wrote:
>>
>> From: Carlo Caione <carlo@endlessm.com>
>>
>> Introduce a new custom dapm routes map to quirk platforms with the
>> internal mic connected to IN2P.
>
>
> LGTM. If we start getting more quirks for this codec, we should think of
> adding a module parameters to select them from the command line or with
> modprobe (as done in other machine drivers).

Hey Pierre,
I'm currently working on a laptop (always with the rt5651 codec)
having two separate internal mics (on IN1P and IN2P) and the headset
on IN3P. I was thinking how to describe this situation in the current
driver without having to add all the 6 different configuration as
quirks. Any suggestion?

Cheers,

-- 
Carlo Caione
