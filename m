From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 03/12] ASoC: dapm: Only mark paths dirty
 when the connection status changed
Date: Wed, 22 Oct 2014 14:10:29 +0200
Message-ID: <54479EB5.2060102@metafoo.de>
References: <1413826604-3212-1-git-send-email-lars@metafoo.de>
 <1413826604-3212-4-git-send-email-lars@metafoo.de>
 <20141022110012.GQ2344@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-082.synserver.de (smtp-out-082.synserver.de
 [212.40.185.82])
 by alsa0.perex.cz (Postfix) with ESMTP id A0CF4264FDF
 for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2014 14:10:29 +0200 (CEST)
In-Reply-To: <20141022110012.GQ2344@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/22/2014 01:00 PM, Mark Brown wrote:
> On Mon, Oct 20, 2014 at 07:36:35PM +0200, Lars-Peter Clausen wrote:
>
>> +static bool soc_dapm_connect_path(struct snd_soc_dapm_path *path,
>> +	bool connect, const char *reason)
>
> Why is this returning a value which is then ignored?
>

I was initially using it to not schedule the dapm_power_widgets(), but there 
is potential for problems when the DAPM graph and the hardware state are 
out-of-sync, in which case we still want to apply the register update. There 
are some corner cases where this can happen and which need to be fixed first.

I can drop the return type for now.

- Lars
