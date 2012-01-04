From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: Does ASoC support sound card with multiple
	interfaces?
Date: Wed, 4 Jan 2012 12:33:39 +0530
Message-ID: <4F03F9CB.20407@st.com>
References: <1325516773.12508.57.camel@matrix>
	<20120102201642.GA30932@sirena.org.uk>
	<1325655413.12508.79.camel@matrix> <4F03E80B.907@st.com>
	<1325660401.12508.113.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog114.obsmtp.com (eu1sys200aog114.obsmtp.com
	[207.126.144.137])
	by alsa0.perex.cz (Postfix) with ESMTP id 6B3D324869
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2012 08:04:05 +0100 (CET)
In-Reply-To: <1325660401.12508.113.camel@matrix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ashish Chavan <ashish.chavan@kpitcummins.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, ";
	Liam Girdwood" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 1/4/2012 12:30 PM, Ashish Chavan wrote:
>
>> You need to redirect it . You can use
>>
>> aplay -Dplughw:0,1 x.wav.
>>
>> Here '0' indicated card number and '1' indicates device number
>
> Is it really mandatory to specify card and device id? Isn't there a
> middle layer that takes care of using "first free" interface for
> playback or recording, if interface is not explicitly specified? As we
> register DAIs with ALSA subsystem, it should be fairly easy for alsa-lib
> to find out "first free" interface.
>
> I am aware that this wouldn't be practically useful in most cases,
> because generally we know beforehand which specific interface to be used
> for playback/recording. In such cases, automatic selection of interface
> may be confusing to users. But I just want to confirm if this is at all
> possible?
>
>

AFAIK, automatic selection is not there

~Rajeev
