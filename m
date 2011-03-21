From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] sound: asoc: Adding support for STA529
	Audio Codec
Date: Mon, 21 Mar 2011 12:07:07 +0000
Message-ID: <20110321120706.GD2570@opensource.wolfsonmicro.com>
References: <1300361016-26242-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1300361016-26242-2-git-send-email-rajeev-dlh.kumar@st.com>
	<1300361016-26242-3-git-send-email-rajeev-dlh.kumar@st.com>
	<20110317151743.GH31411@opensource.wolfsonmicro.com>
	<4D82F7D1.3070704@st.com>
	<20110318113923.GA14017@opensource.wolfsonmicro.com>
	<4D87369F.6020104@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E975A2415E
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 13:07:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D87369F.6020104@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: rajeev <rajeev-dlh.kumar@st.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 21, 2011 at 04:59:35PM +0530, rajeev wrote:

> I agree. So should V2 implement a way in which the register settings desired by
> STA529 (other than the default values) for PLAY and RECORD functionality are programmed
> by means of a hw_params() call?

Without any visibility of what is being configured it's hard to say if
hw_params() is the appropriate place.  For routing controls you'd
usually use DAPM controls.
