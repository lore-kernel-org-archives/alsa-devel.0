From: Moise Gergaud <moise.gergaud@st.com>
Subject: Re: [PATCH 4/4] ASoC: sti: reset iec60958 settings on
	close
Date: Fri, 20 Nov 2015 10:11:00 +0100
Message-ID: <564EE3A4.3090501@st.com>
References: <1447941250-344-1-git-send-email-moise.gergaud@st.com>
 <1447941250-344-5-git-send-email-moise.gergaud@st.com>
 <20151119175024.GP31303@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 17C12260731
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 10:11:05 +0100 (CET)
In-Reply-To: <20151119175024.GP31303@sirena.org.uk>
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

Hello,
To be compliant with SPDIF & HDMI-1.4 by using aplay, driver needs to =

set the channel status sampling freq =3D runtime rate; because channel =

status sampling freq is not set by aplay.
For HBRA, the application set the channel status sampling freq (that is =

different than the runtime rate).
=3D> by taking into account the 2 above cases, for each pcm session, =

driver shall be able to detect if the channel status sampling freq has =

already been set and set it if needed.

And also for robustness purpose: in case the channel status sampling =

freq is not set by the application, I think the driver shall set it.

Maybe I can limit my patch by resetting only the channel status sampling =

freq on close (actual patch reset all the fields of the channel status).

regards
Mo=EFse


On 11/19/2015 06:50 PM, Mark Brown wrote:
> On Thu, Nov 19, 2015 at 02:54:10PM +0100, Moise Gergaud wrote:
>> Reset IEC 60958 settings for next PCM session.
>>
>> Signed-off-by: Moise Gergaud <moise.gergaud@st.com>
>> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>
> It's not 100% clear that we want to do this - normally controls are
> persistent and don't reset themselves per session.  Is this something we
> normally do for such controls?
>
