From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/3] ASoC: pcm: Use wildcard msbits
	constraints
Date: Wed, 31 Dec 2014 17:24:08 +0100
Message-ID: <54A42328.904@metafoo.de>
References: <1419875018-30812-1-git-send-email-lars@metafoo.de>	<1419875018-30812-3-git-send-email-lars@metafoo.de>
 <s5h4msbhk0g.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id DACD9260429
 for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2014 17:24:09 +0100 (CET)
In-Reply-To: <s5h4msbhk0g.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 12/31/2014 05:16 PM, Takashi Iwai wrote:
> At Mon, 29 Dec 2014 18:43:38 +0100,
> Lars-Peter Clausen wrote:
>>
>> Use the new wildcard msbits constraints instead of installing a constraint
>> for each available sample format width.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>
> FYI, as this resulted in a warning, I applied the patch below in
> addition.  Found in topic/msbits branch as well.
>

Thanks. I noticed this today as well when building with a more recent gcc, 
for some reason it didn't show up with an older version.

- Lars
