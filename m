From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [PATCH 0/3] ASoC: stm32: sai: add support of
	iec958 controls
Date: Thu, 17 May 2018 13:03:44 +0000
Message-ID: <dcd08b5c-fc92-4b5d-6950-45afe9db3317@st.com>
References: <1520958428-10930-1-git-send-email-olivier.moysan@st.com>
 <a0552849-47fa-dc72-a512-a3e075adb07f@st.com>
 <20180417111733.GG8973@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F3162671C0
 for <alsa-devel@alsa-project.org>; Thu, 17 May 2018 15:03:49 +0200 (CEST)
In-Reply-To: <20180417111733.GG8973@sirena.org.uk>
Content-Language: en-US
Content-ID: <B86C931B4FF4BD45AA64B0F90C3B2626@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, "tiwai@suse.com" <tiwai@suse.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "robh@kernel.org" <robh@kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "jsarha@ti.com" <jsarha@ti.com>, "rmk@arm.linux.org.uk" <rmk@arm.linux.org.uk>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, Benjamin GAIGNARD <benjamin.gaignard@st.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "kernel@stlinux.com" <kernel@stlinux.com>
List-Id: alsa-devel@alsa-project.org

Hello Takashi,

On 04/17/2018 01:17 PM, Mark Brown wrote:
> On Tue, Apr 17, 2018 at 08:29:17AM +0000, Olivier MOYSAN wrote:
> 
>> I guess the blocking patch in this patchset is the patch "add IEC958
>> channel status control helper". This patch has been reviewed several
>> times, but did not get a ack so far.
>> If you think these helpers will not be merged, I will reintegrate the
>> corresponding code in stm driver.
>> Please let me know, if I need to prepare a v2 without helpers, or if we
>> can go further in the review of iec helpers patch ?
> 
> I don't mind either way but you're right here, I'm waiting for Takashi
> to review the first patch.  I'd probably be OK with it just integrated
> into the driver if we have to go that way though.
> 

Kind reminder.
Would you have some comments on this patchset ?

Thanks
olivier
