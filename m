From: Rajeev kumar <rajeev-dlh.kumar@st.com>
Subject: Re: overrun in case of record
Date: Wed, 7 Sep 2011 09:44:59 +0530
Message-ID: <4E66EFC3.2070706@st.com>
References: <4E65E934.2070706@st.com>
	<20110906180138.GC2924@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eu1sys200aog103.obsmtp.com (eu1sys200aog103.obsmtp.com
	[207.126.144.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CE3C103896
	for <alsa-devel@alsa-project.org>;
	Wed,  7 Sep 2011 06:16:17 +0200 (CEST)
In-Reply-To: <20110906180138.GC2924@opensource.wolfsonmicro.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hello Mark

On 9/6/2011 11:31 PM, Mark Brown wrote:
>> pcm_read error: For this I have seen a bug is locked in the
>> >  bugzila(*Bug 472469*<show_bug.cgi?id=472469>  -arecord: input/output
>> >  error ). and the status  is closed saying insufficient data.
>> >  Could you please let me know what is the meaning of this bug? Is it
>> >  like, data is not available in the buffer and pcm_read from the user
>> >  space fails? But why this situation will
>> >  arise?
> You'll need to investigate the bug.
> .
>
I analyzed the bug and found that if I use arecord  in non-blocking 
mode, it works fine.

#arecord -f dat  --nonblock >  t

Working in a non-blocking  mode means there is no data available in ring 
buffer and returning -EAGAIN from the alsa, so application is
wating for data to arrive in the ring buffer. Now it is not clear to me 
why this situation will arise?
I have checked the clock and all the clock are intact. The calculation 
for number of bytes received in a sec is correct.

Best Regards
Rajeev
