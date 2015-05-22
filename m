From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v2 1/9] ASoC: sti: add binding for ASoc
	driver
Date: Fri, 22 May 2015 15:24:10 +0200
Message-ID: <555F2DFA.306@st.com>
References: <1431951176-24670-1-git-send-email-arnaud.pouliquen@st.com>
 <1431951176-24670-2-git-send-email-arnaud.pouliquen@st.com>
 <20150522124328.GV21391@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com
 [91.207.212.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 1C238265E23
 for <alsa-devel@alsa-project.org>; Fri, 22 May 2015 15:24:15 +0200 (CEST)
In-Reply-To: <20150522124328.GV21391@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Oops...sorry, i missed to clean these lines...
I suppressed standby mode in my V2. I plan to propose this mode in a 
separate patch based on DAPM...
I let you check the rest of the patches then will clean lines in the V3

On 05/22/2015 02:43 PM, Mark Brown wrote:
> On Mon, May 18, 2015 at 02:12:48PM +0200, Arnaud Pouliquen wrote:
>
>> Add Asoc driver bindings documentation.
>
> ASoC.
>
>> +  - standby:  standby mode activation deactivation. this mode is specific to
>> +	      Uni player IP and allows to transmit bus clock and a pattern data
>> +	      while audio stream is stopped or paused.
>> +  - auto-suspend-delay: runtime auto suspend delay (in ms) before deactivating
>> +			stanby mode. Equivalent to the DAPM mechanism but for
>> +			CPU DAI.
>
> It's still not clear to me that these are things that should be
> configured via the DT.  Otherwise this looks OK.
>
