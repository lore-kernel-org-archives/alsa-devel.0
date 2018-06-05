From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH 0/3] ASoC: stm32: sai: add support of
 iec958 controls
Date: Tue, 5 Jun 2018 17:50:57 +0200
Message-ID: <2ae6c5b6-872a-9aaa-6ca4-e29adb7c8bc0@st.com>
References: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
 <a0552849-47fa-dc72-a512-a3e075adb07f@st.com>
 <20180417111733.GG8973@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 1F736267A6C
 for <alsa-devel@alsa-project.org>; Tue,  5 Jun 2018 17:51:03 +0200 (CEST)
In-Reply-To: <20180417111733.GG8973@sirena.org.uk>
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
To: Mark Brown <broonie@kernel.org>, Olivier MOYSAN <olivier.moysan@st.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "robh@kernel.org" <robh@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "jsarha@ti.com" <jsarha@ti.com>, "tiwai@suse.com" <tiwai@suse.com>, "kernel@stlinux.com" <kernel@stlinux.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, Benjamin GAIGNARD <benjamin.gaignard@st.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

On 04/17/2018 01:17 PM, Mark Brown wrote:
> On Tue, Apr 17, 2018 at 08:29:17AM +0000, Olivier MOYSAN wrote:
> =

>> I guess the blocking patch in this patchset is the patch "add IEC958 =

>> channel status control helper". This patch has been reviewed several =

>> times, but did not get a ack so far.
>> If you think these helpers will not be merged, I will reintegrate the =

>> corresponding code in stm driver.
>> Please let me know, if I need to prepare a v2 without helpers, or if we =

>> can go further in the review of iec helpers patch ?
> =

> I don't mind either way but you're right here, I'm waiting for Takashi
> to review the first patch.=A0 I'd probably be OK with it just integrated
> into the driver if we have to go that way though.

Gentlemen reminder for this patch set. We would appreciate to have your
feedback on iec helper.
>From our point of view it could be useful to have a generic management
of the iec controls based on helpers instead of redefining them in DAIs.
Having the same behavior for these controls could be useful to ensure
coherence of the control management used by application (for instance
Gstreamer uses it to determine iec raw mode capability for iec61937 streams)


Thanks,
Arnaud
