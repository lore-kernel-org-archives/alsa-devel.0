From: Olivier MOYSAN <olivier.moysan@st.com>
Subject: Re: [RFC PATCH 2/2] ASoC: wm8994: delay aifxclk
	activation
Date: Fri, 17 Mar 2017 15:37:24 +0000
Message-ID: <6a5eb30d-bb98-4216-8b0a-4fdb38cd80e4@st.com>
References: <1489682483-13051-1-git-send-email-olivier.moysan@st.com>
 <1489682483-13051-3-git-send-email-olivier.moysan@st.com>
 <20170316175152.hqipd5yvfdrt2ywd@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 7E1402669D8
 for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2017 16:37:27 +0100 (CET)
In-Reply-To: <20170316175152.hqipd5yvfdrt2ywd@sirena.org.uk>
Content-Language: en-US
Content-ID: <6D67799633E6F34EAB6FD8B383A27787@st.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Alexandre TORGUE <alexandre.torgue@st.com>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "tiwai@suse.com" <tiwai@suse.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hello Mark,

On 03/16/2017 06:51 PM, Mark Brown wrote:
> On Thu, Mar 16, 2017 at 05:41:23PM +0100, olivier moysan wrote:
>> Signed-off-by: olivier moysan <olivier.moysan@st.com>
>> ---
>>  sound/soc/codecs/wm8994.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> ...with no changelog.  That's especially important here, we really don't
> want to be messing with the clock activation ordering on this device
> without a good and clear understanding of what's going on.
>

Sorry. I put it in cover letter only.
I send a v2 with more explanations.

regards
olivier
