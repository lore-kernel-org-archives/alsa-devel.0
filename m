From: Carlo Caione <carlo@endlessm.com>
Subject: Re: [PATCH v2] ASoC: cht_bsw_rt5645: Fix writing to
	string literal
Date: Thu, 3 Mar 2016 13:47:13 +0100
Message-ID: <CAL9uMOHyqZeFBhLaW2Dh+NiVmCZ29eKzU4ABUd500x4eh=O02w@mail.gmail.com>
References: <1456217420-9327-1-git-send-email-carlo@caione.org>
 <20160226021210.GE18327@sirena.org.uk>
 <20160303113255.GL11154@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f169.google.com (mail-ig0-f169.google.com
 [209.85.213.169])
 by alsa0.perex.cz (Postfix) with ESMTP id CE1BA260535
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 13:47:14 +0100 (CET)
Received: by mail-ig0-f169.google.com with SMTP id hb3so63450821igb.0
 for <alsa-devel@alsa-project.org>; Thu, 03 Mar 2016 04:47:14 -0800 (PST)
In-Reply-To: <20160303113255.GL11154@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Yang Fang <yang.a.fang@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@caione.org>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 3, 2016 at 12:32 PM, Vinod Koul <vinod.koul@intel.com> wrote:
> On Fri, Feb 26, 2016 at 11:12:10AM +0900, Mark Brown wrote:
>> On Tue, Feb 23, 2016 at 09:50:20AM +0100, Carlo Caione wrote:
>> > From: Carlo Caione <carlo@endlessm.com>
>> >
>> > We cannot use strcpy() to write to a const char * location. This is
>> > causing a 'BUG: unable to handle kernel paging request' error at boot
>> > when using the cht-bsw-rt5645 driver.
>> >
>> > With this patch we also fix a wrong indexing in the driver where the
>> > codec_name of the wrong dai_link is being overwritten.
>>
>> So how was the original code tested then...?
>
> I know systems using this are shipping so surprised to see this.
>
> Carlo cna you please tell me the configuration where it is seen.

Hi Vinod,
I'm working on the ECS EF20EA cherry-trail laptop. This is the used
configuration:

https://gist.github.com/carlocaione/925540bc7b04eff01aa8

Cheers,

-- 
Carlo Caione  |  +39.340.80.30.096  |  Endless
