From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: RFC: ST specific ASoC sound driver
Date: Wed, 16 Mar 2011 11:22:14 +0000
Message-ID: <20110316112214.GB14125@opensource.wolfsonmicro.com>
References: <4D809928.2000905@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E23AA103938
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 12:22:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D809928.2000905@st.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 16, 2011 at 04:34:08PM +0530, rajeev wrote:

Please remember to CC maintainers on mails - I've added Liam.

> I have developed a ASoC sound driver for a ST specific platform (SPEAr).
> This module actually uses the Designware (Synopsys) "dw_apb_i2s_db" IP
> + some ST specific glue logic on top of it.

> Now I am confused as to whether I should submit a single patch for
> the SPEAr ASoC driver or should I try to break the driver such that
> the Designware and glue logic parts are handled separately (which given
> the current shape of design seems improbable)

Ideally it'd be split so other people could share the off the shelf
DesignWare code if they also use the IP but it really depends on what
exactly the ST specific customisations do and how much control is
required for the generic part - if the control for the IP is trivial
or the changes are very invasive then there's less value in splitting
it.  Without seeing the code it's difficult to comment.
