From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Mon, 17 Dec 2018 12:08:36 -0600
Message-ID: <273cb3d8-7cd6-867a-ebb4-22217f88e0a8@linux.intel.com>
References: <20181114230255.GG2089@sirena.org.uk>
 <b48bc9d6-767a-24df-692e-fe675afed22e@gmail.com>
 <20181115003313.GH2089@sirena.org.uk>
 <56e02571-fd5b-0add-c6c7-98e4f746448c@gmail.com>
 <20181115190403.GI2089@sirena.org.uk>
 <00b68fe8-403d-b129-1166-f414e5bd21ab@gmail.com>
 <724efe46-d604-0de1-caa2-efcfd7c91510@gmail.com>
 <20181213174229.GU10669@sirena.org.uk>
 <fff018b4-c2e5-d3f3-0589-b837e62e9c5e@gmail.com>
 <4b358258-d7ae-d82e-cd58-d4b9e3b6f148@linux.intel.com>
 <20181217173930.GF27909@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id A5211267B09
 for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2018 19:08:38 +0100 (CET)
In-Reply-To: <20181217173930.GF27909@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Dimitris Papavasiliou <dpapavas@gmail.com>
List-Id: alsa-devel@alsa-project.org


On 12/17/18 11:39 AM, Mark Brown wrote:
> On Mon, Dec 17, 2018 at 09:03:33AM -0600, Pierre-Louis Bossart wrote:
>
>> I started prototyping a different approach where the codec driver passes=
 the
>> regmap information to the clock driver. What's missing in the patchset is
>> the addition of a clock control in the machine driver, and logic added so
>> that rate=A0 change can only be done in a hw_params if there was a compl=
ete
>> stop and reset on a DAPM_OFF event. compile-tested only for now.
>> https://github.com/plbossart/sound/commits/hifiberry/clks
> That looks a lot like the CODEC should be exporting a GPIO driver so the
> machine driver doesn't actually need the regmap?  The only register
> touched is _GPIO_CONTROL_1.

I am not sure what you meant by 'exporting a GPIO driver' (mostly =

because I am not familiar with any GPIO framework) but indeed the local =

oscillator choice is controlled by a single register accessible through =

regmap - and changes to that register should only happen when the device =

is a specific state to prevent click/pops.

The machine driver should use clk_set_rate() and not directly handle =

regmap or codec stuff. If it does, or if the clock framework isn't =

relevant here then we can simplify all this as suggested in =

https://patchwork.kernel.org/patch/10444387/. What I was trying to do =

with the github update is to keep the clock framework, tie it closer =

with the codec parts with a state variable that prevents wild changes =

without going back to a 'safe' idle state (similar idea as PulseAudio =

clock changes, which can only happen when the PCM is not opened and used).
