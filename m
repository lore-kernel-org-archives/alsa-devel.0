From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Wed, 19 Dec 2018 23:44:46 +0200
Message-ID: <8c996338-19a3-996b-16dc-5535688ccea2@gmail.com>
References: <20181213174229.GU10669@sirena.org.uk>
 <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
 <20181217123703.GF13868@sirena.org.uk>
 <7dbf7969-c0ea-fe13-2044-17f36e458e21@gmail.com>
 <20181217141008.GA27909@sirena.org.uk>
 <53b182ce-c12b-6b97-4e26-f80d0651e8fa@gmail.com>
 <20181217154043.GC27909@sirena.org.uk>
 <f743bf6b-b10a-6c00-57d7-3a0df67d7bba@gmail.com>
 <20181217165257.GD27909@sirena.org.uk>
 <5a2103c5-194b-cb21-672e-d472e91825a8@gmail.com>
 <20181219161949.GD8130@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by alsa0.perex.cz (Postfix) with ESMTP id D802226782E
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 22:44:49 +0100 (CET)
Received: by mail-wm1-f65.google.com with SMTP id n190so7546138wmd.0
 for <alsa-devel@alsa-project.org>; Wed, 19 Dec 2018 13:44:49 -0800 (PST)
In-Reply-To: <20181219161949.GD8130@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On 12/19/18 6:19 PM, Mark Brown wrote:
> If you're saying you're keeping the device open while you're doing this
> (rather than closing the stream and reconfiguring) then I'd expect
> you're going to find other hardware which has similar issues, reclocking
> the device isn't something I'd expect to be able to do glitch free.

I got pops even if I opened the stream, called hw_params and closed it
on each iteration, but, as it turns out, that was in part because I
was being lazy, using a Python script to do the above, which sneaked
in a hw_params call immediately after opening the stream, to "reset"
it to default values.

So I've retried your suggested approach.  It looks like setting
.ignore_pmdown_time = 1 in the snd_soc_dai_link of the machine driver
is enough to cause immediate power ups/downs, but I get the following
behavior: The device gets powered up immediately after the first
hw_params call (even if nothing gets played subsequently) and it gets
powered down immediately after it's closed.  This does avoid the pop
when the device gets configured right after opening it, which, as you
say, seems to be what usually happens (I checked with the SoX play
utility and the MPD), but a pop is generated if there are multiple
hw_params calls and the sample rate is changed in any but the first one
(where the device is still powered down).

This can conceivably happen (for instance the Python library I was
using, forces you to make multiple hw_params calls, in order to set
more than one parameters).  Is there some way to configure the DAPM to
power up the card right before playback starts, and power it down
right after it stops?  This would prevent pops even in such
pathological cases.

>From what I could glean from the documentation on DAPM it seems like
that might be possible via stream domain widgets, but the CODEC driver
already defines those and the device is still powered up before
playback is requested.
