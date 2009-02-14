From: Bryan Wu <cooloney@kernel.org>
Subject: Re: [PATCH 3/3] ASoC: Blackfin: fix bug - kernel will
	crash when record and play in bf527-ezkit
Date: Sat, 14 Feb 2009 23:36:40 +0800
Message-ID: <386072610902140736u25f9a70haa9b836c4f9ce252@mail.gmail.com>
References: <1233915156-17985-1-git-send-email-cooloney@kernel.org>
	<1233915156-17985-4-git-send-email-cooloney@kernel.org>
	<20090206115626.GD8723@sirena.org.uk>
	<20090213201816.GA6410@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by alsa0.perex.cz (Postfix) with ESMTP id 2F85C1037F8
	for <alsa-devel@alsa-project.org>; Sat, 14 Feb 2009 16:36:41 +0100 (CET)
Received: by wf-out-1314.google.com with SMTP id 26so1658060wfd.23
	for <alsa-devel@alsa-project.org>; Sat, 14 Feb 2009 07:36:41 -0800 (PST)
In-Reply-To: <20090213201816.GA6410@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 14, 2009 at 4:18 AM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Fri, Feb 06, 2009 at 11:56:45AM +0000, Mark Brown wrote:
>
>> > set constraint only if the value is not 0, change the configuring way for sport
>
>> If this is fixing a kernel crash we should push it for 2.6.29 (the code
>> hasn't changed so I'm assuming it occurs there).  What is the crash that
>> is being fixed?
>
> Any updates on this?
>

Sorry for the delay. I will split this patch into 2 patches. And
resent them to soon.

Thanks
-Bryan
