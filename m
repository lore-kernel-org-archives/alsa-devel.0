From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
 driver
Date: Tue, 18 Dec 2018 08:12:14 -0600
Message-ID: <a63aa724-a513-80c3-6163-574d287cde06@linux.intel.com>
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
 <273cb3d8-7cd6-867a-ebb4-22217f88e0a8@linux.intel.com>
 <fcb1acd1-6485-0c3d-8350-82a6f003f320@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id 63C712677C8
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 15:12:16 +0100 (CET)
In-Reply-To: <fcb1acd1-6485-0c3d-8350-82a6f003f320@gmail.com>
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
To: Dimitris Papavasiliou <dpapavas@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 12/18/18 5:32 AM, Dimitris Papavasiliou wrote:
> On 12/17/18 8:08 PM, Pierre-Louis Bossart wrote:
>
>> The machine driver should use clk_set_rate() and not directly handle =

>> regmap or codec stuff. If it does, or if the clock framework isn't =

>> relevant here then we can simplify all this as suggested in =

>> https://patchwork.kernel.org/patch/10444387/. What I was trying to do =

>> with the github update is to keep the clock framework, tie it closer =

>> with the codec parts with a state variable that prevents wild changes =

>> without going back to a 'safe' idle state (similar idea as PulseAudio =

>> clock changes, which can only happen when the PCM is not opened and =

>> used).
>
> I have documented, in a previous message, various approaches I tried
> to prevent the pop, which were mostly based on the assumption that the
> clock source was changed too "abruptly", or wasn't allowed to settle.
> In the end, the only state, where the clocks can be switched without a
> pop seemed to be when the chip is suspended.
>
> It would of course be great if this could be achieved in a natural
> manner, by waiting for the card to be suspended and only switching
> clocks in such a state, but I don't see how this can be achieved
> robustly.=A0 The power management behavior is outside of the control of
> the machine driver, so it can only refuse to switch sample rate when
> it's not suspended.=A0 Perhaps this will work in practice, but I fear it
> would break applications depending on less restrained control of the
> hardware.

My point was that the machine driver can track DAPM events and put the =

device in a 'safe' state on SND_SOC_DAPM_EVENT_OFF so that the rate can =

be changed when playback restarts. I don't see what prevents us from =

using the same config as during suspend? It's pretty common to play with =

clocks with these events, and calling clk_disable_unprepare() could lead =

to whatever configuration sequence is needed for pop-free restart on =

startup.
