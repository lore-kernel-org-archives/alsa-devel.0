From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Audio:suspend to ram issue
Date: Fri, 19 Aug 2011 01:25:36 +0900
Message-ID: <20110818162535.GG20208@opensource.wolfsonmicro.com>
References: <4E4CABBC.20901@st.com>
 <4E4CEEB9.2000604@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 50B5E2447D
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Aug 2011 18:25:43 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4E4CEEB9.2000604@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev kumar <rajeev-dlh.kumar@st.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 18, 2011 at 04:21:37PM +0530, Rajeev kumar wrote:

> Is there any difference between these two suspend  ctrl-z and echo
> mem > /sys/power/state.

Yes.  For example in system suspend it is likely that some of the system
power supplies will be disabled and low power states will be entered
which cause register contents to be lost.

> While going through the alsa framework I found that suspend and
> resume functionality is handled by
> the framework itself.Please correct me if my understanding is not correct.

DAPM will be taken care of but there is usually some other work
required, if only restoring the register maps of devices.  There are
callbacks into the individual drivers in order to allow them to take
whatever action is required to quiesce and restore the device.
