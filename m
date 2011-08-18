From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: Audio:suspend to ram issue
Date: Thu, 18 Aug 2011 16:21:37 +0530
Message-ID: <4E4CEEB9.2000604@st.com>
References: <4E4CABBC.20901@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog114.obsmtp.com (eu1sys200aog114.obsmtp.com
	[207.126.144.137])
	by alsa0.perex.cz (Postfix) with ESMTP id 67E1E24696
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Aug 2011 12:52:26 +0200 (CEST)
In-Reply-To: <4E4CABBC.20901@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hello Mark
In the continuation of the last mail.I run alsa_aplay and the WAV file 
sounds.
Then press ctrl-z - aplay will go to background(suspend state) and i2s 
is stopped.
Then type fg and the audio  restart.
Is there any difference between these two suspend  ctrl-z and echo mem > 
/sys/power/state.
In both the cases trigger will call with cmd value '1 ' in case of 
resume and '0' in case of suspend.

While going through the alsa framework I found that suspend and resume 
functionality is handled by
the framework itself.Please correct me if my understanding is not correct.

Best Regards
Rajeev


On 8/18/2011 11:35 AM, Rajeev kumar wrote:
>
> Hi Mark
> I am not sure about the behavior in case of audio suspend/resume.
>
> I tested the audio driver with aplay and then suspended to ram (using 
> echo mem > /sys/power/state). After pressing wake to resume,
> the audio does not play unless aplay is closed and re-run.  Do we 
> expect the audio suspend/resume to work?
>
> In the platform trigger part I am doing nothing and in case of 
> cpu(i2s) , just disabling the i2s.
>
> Best Regards
> Rajeev
