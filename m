From: Vipin Kumar <vipin.kumar@st.com>
Subject: Re: [PATCH V3 3/4] ASoC: SPEAr spdif_out: Add spdif
	out support
Date: Sun, 1 Jul 2012 12:02:31 +0530
Message-ID: <4FEFEEFF.7040204@st.com>
References: <cover.1340862505.git.rajeev-dlh.kumar@st.com>
	<ef5b01e2bff6cb1e72db4e2d216d1a039a048e62.1340862505.git.rajeev-dlh.kumar@st.com>
	<20120628122727.GI28922@opensource.wolfsonmicro.com>
	<4FED5AB1.6030907@st.com>
	<20120630183558.GB28922@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog112.obsmtp.com (eu1sys200aog112.obsmtp.com
	[207.126.144.133])
	by alsa0.perex.cz (Postfix) with ESMTP id A299324796
	for <alsa-devel@alsa-project.org>;
	Sun,  1 Jul 2012 08:32:41 +0200 (CEST)
In-Reply-To: <20120630183558.GB28922@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Rajeev KUMAR <rajeev-dlh.kumar@st.com>, "tiwai@suse.de" <tiwai@suse.de>, spear-devel <spear-devel@list.st.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On 7/1/2012 12:05 AM, Mark Brown wrote:
> On Fri, Jun 29, 2012 at 01:05:13PM +0530, Vipin Kumar wrote:
>> On 6/28/2012 5:57 PM, Mark Brown wrote:
>
>>>> +	.ops = (struct snd_soc_dai_ops *)&spdif_out_dai_ops,
>
>>> Why do you need this cast?
>
>> It was a const I think
>
> So you've just introduced a bug, then - you're using a const variable in
> a non-const context.  Don't cast away the const, either arrange for the
> ops pointer in the dai to be const or remove the const.

sure, i will do that...got it :)
