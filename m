From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Audio:suspend to ram issue
Date: Fri, 19 Aug 2011 17:21:58 +0900
Message-ID: <1313742118.19990.146.camel@finisterre.wolfsonmicro.main>
References: <4E4CABBC.20901@st.com> <4E4CEEB9.2000604@st.com>
	<20110818162535.GG20208@opensource.wolfsonmicro.com>
	<4E4DE55E.5080402@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 68E63103822
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Aug 2011 23:55:02 +0200 (CEST)
In-Reply-To: <4E4DE55E.5080402@st.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 2011-08-19 at 09:53 +0530, Rajeev kumar wrote:

> Is it necessary to  implement DAPM?

It's only really relevant for CODEC drivers. For CODEC drivers it's
essentially mandatory, for CPU drivers it's not relevant.

> one more point I would like to mention that there is no any 
> suspend/resume function I have implemented in the cpu driver
> as i thought this is handled by the framework itself.Am I correct?

I can only repeat what I said in my previous mail - if there are any
steps required to quiesce the hardware for suspend or restore it from
the lower power states entered on on suspend then these should be
handled in suspend and resume methods. If your hardware does not require
any actions outside what you're already doing and there's nothing extra
for suspend and resume methods to implement then there's nothing to do.
The framework doesn't know anything about your hardware or the
particular requirements it has.
