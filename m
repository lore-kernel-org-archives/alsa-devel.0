From: "Bryan Wu" <cooloney@kernel.org>
Subject: Re: [PATCH 1/1] ASoC Blackfin: add asoc ad73311 driver
	supporting in Blackfin boards
Date: Sat, 27 Sep 2008 21:43:10 +0800
Message-ID: <386072610809270643j5f59c621ue323afc6f2fd1d7b@mail.gmail.com>
References: <1222505943-22457-1-git-send-email-cooloney@kernel.org>
	<20080927094117.GC3330@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f17.google.com (mail-gx0-f17.google.com
	[209.85.217.17])
	by alsa0.perex.cz (Postfix) with ESMTP id 23163103844
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Sep 2008 15:43:10 +0200 (CEST)
Received: by gxk10 with SMTP id 10so10750811gxk.8
	for <alsa-devel@alsa-project.org>; Sat, 27 Sep 2008 06:43:10 -0700 (PDT)
In-Reply-To: <20080927094117.GC3330@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bryan Wu <cooloney@kernel.org>, alsa-devel@alsa-project.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Sep 27, 2008 at 5:41 PM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Sat, Sep 27, 2008 at 04:59:03PM +0800, Bryan Wu wrote:
>> From: Cliff Cai <cliff.cai@analog.com>
>>
>> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
>> Signed-off-by: Bryan Wu <cooloney@kernel.org>
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> Looks good - one thing that might help people reading the changelogs
> for features might be to split out the I2S changes from the machine
> driver.  As well as supporting the AD73311 machines this also makes
> the I2S driver more flexible which is a much more general feature
> and would be more clearly highlighted with a separate changelog entry.
>

No problem, I will split out the I2S changes here.

-Bryan
