From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: wm9712/wm9713: Replace
	virtual	registers with custom put/get callbacks
Date: Sat, 8 Nov 2014 12:43:12 +0000
Message-ID: <20141108124312.GZ23178@opensource.wolfsonmicro.com>
References: <1415039583-4858-1-git-send-email-lars@metafoo.de>
 <1415039583-4858-3-git-send-email-lars@metafoo.de>
 <545C9678.2050203@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B77F0260441
 for <alsa-devel@alsa-project.org>; Sat,  8 Nov 2014 13:43:12 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <545C9678.2050203@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Robert Jarzmik <robert.jarzmik@free.fr>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 07, 2014 at 10:52:56AM +0100, Lars-Peter Clausen wrote:
> On 11/03/2014 07:33 PM, Lars-Peter Clausen wrote:
>> The wm9712/wm9713 has separate mixers for the left and the right channel,
>> but the inputs to the mixers are enabled/disabled by the same control.
>> Currently this is implemented by the driver by registering two virtual
>> controls for each physical control, one for the left mixer and one for the
>> right mixer.
>>
>> Using virtual registers will no longer work when the driver has
>> been converted to regmap. This patch converts the driver to use controls
>> with custom put/get callbacks instead which implement the logic making sure
>> that the physical control is unmuted when either the left or the right
>> control is unmuted.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>
> Hi Charles,
>
> Given your usual fast responses on patches I'm suspecting that this one 
> may have been lost. If not I apologize for the noise.
>
> Thanks,
> - Lars

Apologies for that, it must have come in on a busy morning and
then I forgot to come back to it.

All looks good to me and seems Mark has applied it now.

Thanks,
Charles
