From: Moise Gergaud <moise.gergaud@st.com>
Subject: Re: [PATCH 2/2] ASoC: sti: correction for HBRA support
Date: Tue, 1 Dec 2015 13:27:59 +0100
Message-ID: <565D924F.6000606@st.com>
References: <1448370996-30224-1-git-send-email-moise.gergaud@st.com>
 <1448370996-30224-3-git-send-email-moise.gergaud@st.com>
 <20151130163057.GA1929@sirena.org.uk> <565D6DCE.50906@st.com>
 <20151201113510.GF1929@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id 71075265C99
 for <alsa-devel@alsa-project.org>; Tue,  1 Dec 2015 13:28:05 +0100 (CET)
In-Reply-To: <20151201113510.GF1929@sirena.org.uk>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On 12/01/2015 12:35 PM, Mark Brown wrote:
> On Tue, Dec 01, 2015 at 10:52:14AM +0100, Moise Gergaud wrote:
>> On 11/30/2015 05:30 PM, Mark Brown wrote:
>>> On Tue, Nov 24, 2015 at 02:16:36PM +0100, Moise Gergaud wrote:
>>>> Detect HBRA based on rate and channels used in the pcm session
>>>> In case of HBRA:
>>>>    - CH_STS repeat is disabled
>>>>    - channel status sampling freq is not set if already set (because it can
>>>>      be a multiple of the runtime rate)
>
>>> You might want to expand HBRA...
>
>> you mean in term of frequency?
>
> No, I mean tell people what the acronym means.  It's probably *not*
> Herefordshire Breech-Loading Rifle Association which is the first hit on
> Google for me and even adding iec958 to the search term mostly just
> turns up this driver.
>

ok, sorry, I didn't get your point.
I'll expand the acronym.
HBRA = High Bit Rate Audio
