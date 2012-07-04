From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: [PATCH V4 1/2] ASoC: STA529: Add support for
	STA529 Audio Codec
Date: Wed, 4 Jul 2012 10:36:55 +0530
Message-ID: <4FF3CF6F.1000106@st.com>
References: <cover.1341312609.git.rajeev-dlh.kumar@st.com>
	<0fec3fec69088f016a1093da6dab010a8eb4e599.1341312609.git.rajeev-dlh.kumar@st.com>
	<20120703190300.GA29030@opensource.wolfsonmicro.com>
	<4FF3CDE8.3020206@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog117.obsmtp.com (eu1sys200aog117.obsmtp.com
	[207.126.144.143])
	by alsa0.perex.cz (Postfix) with ESMTP id 1A1471042C0
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2012 07:07:01 +0200 (CEST)
In-Reply-To: <4FF3CDE8.3020206@st.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Rajeev kumar <rajeev-dlh.kumar@st.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi all,

On 7/4/2012 10:30 AM, Rajeev kumar wrote:
> Hello Mark,
>
> On 7/4/2012 12:33 AM, Mark Brown wrote:
>> On Tue, Jul 03, 2012 at 05:24:58PM +0530, Rajeev Kumar wrote:
>>
>>> +
>>> + /* set FFX audio frequency range */
>>> + val = (((val& 0x83) | (play_freq_val<< 4)) | (record_freq_val<< 2));
>>> + snd_soc_update_bits(codec, STA529_MISC, FREQ_RANGE_MSK, val);
>>
>> This is more buggy than last time, it's still setting both playback and
>> record configuration but instead of using update_bits() like write()
>> it's now using val uninitialised. As I said last time it looks like you
>> want to move this into the playback/capture if statement immediately
>> above.
>
>

Please ignore this mail, by mistake I had sent this, sorry

Best Regards
Rajeev
