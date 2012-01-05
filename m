From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Does ASoC support sound card with
	multiple	interfaces?
Date: Thu, 5 Jan 2012 06:02:55 +0000
Message-ID: <20120105060255.GF11867@opensource.wolfsonmicro.com>
References: <1325516773.12508.57.camel@matrix>
	<20120102201642.GA30932@sirena.org.uk>
	<1325655413.12508.79.camel@matrix> <4F03E80B.907@st.com>
	<1325660401.12508.113.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 48328103918
	for <alsa-devel@alsa-project.org>; Thu,  5 Jan 2012 07:02:57 +0100 (CET)
Content-Disposition: inline
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Rajeev kumar <rajeev-dlh.kumar@st.com>, "; Liam Girdwood" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Jan 04, 2012 at 12:30:01PM +0530, Ashish Chavan wrote:

> Is it really mandatory to specify card and device id? Isn't there a
> middle layer that takes care of using "first free" interface for
> playback or recording, if interface is not explicitly specified? As we
> register DAIs with ALSA subsystem, it should be fairly easy for alsa-lib
> to find out "first free" interface.

That's not implemented since genuinely identical interfaces should be
implemented by supporting multiple opens on a single device but those
essentailly don't exist in embedded hardware.  Pretty much all embedded
hardware with multiple routes out of the CPU has either distinct fixed
functions for the outputs or independant routing of them so they can't
reliably be used interchangibly.

You could implement it but it'd have to be a system specific option to
use it.
