From: Qiao Zhou <zhouqiao@marvell.com>
Subject: Re: [PATCH] ASoC: soc-pcm: skip dpcm path checking
 with incapable/unready FE
Date: Mon, 24 Nov 2014 09:44:36 +0800
Message-ID: <54728D84.8040504@marvell.com>
References: <1416211377-9559-1-git-send-email-zhouqiao@marvell.com>
 <20141121193201.GN3815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by alsa0.perex.cz (Postfix) with ESMTP id EA203261A5E
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 02:44:06 +0100 (CET)
In-Reply-To: <20141121193201.GN3815@sirena.org.uk>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 11/22/2014 03:32 AM, Mark Brown wrote:
> On Mon, Nov 17, 2014 at 04:02:57PM +0800, Qiao Zhou wrote:
>> Skip dpcm path checking for playback or capture, if corresponding FE
>> doesn't support playback or capture, or currently is not ready. It
>> can reduce the unnecessary cost to search connected widgets.
>
> Applied, but I did change...
>
>> +		/* skip if FE doesn't do playback */
>> +		if (!fe->cpu_dai->playback_active
>> +		    || !fe->codec_dai->playback_active)
>
> ...this and the corresponding capture comment to say "isn't currently
> playing" - it's not if the front end can play, it's if it is playing
> right now.
>
Mark,

Thanks for the correction.

-- 

Best Regards
Qiao
