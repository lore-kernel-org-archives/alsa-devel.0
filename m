From: Moise Gergaud <moise.gergaud@st.com>
Subject: Re: [PATCH 4/4] ASoC: sti: reset iec60958 settings on
	close
Date: Mon, 23 Nov 2015 09:50:43 +0100
Message-ID: <5652D363.3090105@st.com>
References: <1447941250-344-1-git-send-email-moise.gergaud@st.com>
 <1447941250-344-5-git-send-email-moise.gergaud@st.com>
 <20151119175024.GP31303@sirena.org.uk> <564EE3A4.3090501@st.com>
 <20151121124509.GC26072@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id AC9EB2651CB
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 09:50:47 +0100 (CET)
In-Reply-To: <20151121124509.GC26072@sirena.org.uk>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 11/21/2015 01:45 PM, Mark Brown wrote:
> On Fri, Nov 20, 2015 at 10:11:00AM +0100, Moise Gergaud wrote:
>> Hello,
>
> Please don't top post, reply in line deleting unneeded text.  This
> provides relevant context so people reading your mail can understand
> what you are talking about.
>
>> To be compliant with SPDIF & HDMI-1.4 by using aplay, driver needs to set
>> the channel status sampling freq = runtime rate; because channel status
>> sampling freq is not set by aplay.
>> For HBRA, the application set the channel status sampling freq (that is
>> different than the runtime rate).
>> => by taking into account the 2 above cases, for each pcm session, driver
>> shall be able to detect if the channel status sampling freq has already been
>> set and set it if needed.
>
>> And also for robustness purpose: in case the channel status sampling freq is
>> not set by the application, I think the driver shall set it.
>
> None of this addresses my concern, sorry - your change is just trashing
> all the settings that the application is setting.  This is not what we
> normally do with controls and is going to break correctly functioning
> applications that play audio with the same parameters repeatedly.
>
>> Maybe I can limit my patch by resetting only the channel status sampling
>> freq on close (actual patch reset all the fields of the channel status).
>
> This isn't something you should be inventing policies for in a single
> driver, the kernel needs to offer consistent interfaces to applications
> no matter which particular hardware the system is running.  If we want
> to do something here it should be done at ALSA level.  It does seem like
> a reasonable idea to put the sample rate into kernel control, I can't
> think of a situation where we'd want to advertise the wrong sample rate,
> but it does need to be in the core not a specific driver.
>

Agree that this should be done at ALSA level.
Taking into consideration this will be done at ALSA level, I still need 
to correct ASOC STI driver: force the iec958 channel status sampling 
rate to the runtime rate without any condition. I'll provide patch V2.
