From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] sound: asoc: Adding support for STA529
	Audio Codec
Date: Tue, 22 Mar 2011 11:34:20 +0000
Message-ID: <20110322113419.GA22583@opensource.wolfsonmicro.com>
References: <1300361016-26242-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1300361016-26242-2-git-send-email-rajeev-dlh.kumar@st.com>
	<1300361016-26242-3-git-send-email-rajeev-dlh.kumar@st.com>
	<20110317151743.GH31411@opensource.wolfsonmicro.com>
	<4D82F7D1.3070704@st.com>
	<20110318113923.GA14017@opensource.wolfsonmicro.com>
	<4D87369F.6020104@st.com>
	<20110321120706.GD2570@opensource.wolfsonmicro.com>
	<4D883964.4070100@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DF88C103809
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 12:34:22 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4D883964.4070100@st.com>
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

On Tue, Mar 22, 2011 at 11:23:40AM +0530, rajeev wrote:

> The configuration is related to Serial-to-parallel audio interface,Parallel-to-serial audio interface
> ,ADC configuration register etc.These are the basic setting related to initialization for sta529 codec.
> Can I make it in this way
> In probe function read the corresponding register value from register cache and write the actual value to the codec.
> like it is done in [1]

It does depend on exactly what's being configured for them but that does
sound reasonable.  Send the patch like that and we'll review it.
