From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
Date: Mon, 11 Jan 2016 15:10:20 +0100
Message-ID: <5693B7CC.8000905@maciej.szmigiero.name>
References: <5677107C.60904@maciej.szmigiero.name> <CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com> <CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com> <20160111140038.GC6588@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160111140038.GC6588@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 11.01.2016 15:00, Mark Brown wrote:
> On Mon, Jan 11, 2016 at 10:10:56AM -0200, Fabio Estevam wrote:
>> On Mon, Jan 11, 2016 at 10:04 AM, Fabio Estevam <festevam@gmail.com> wrote:
> 
>>> [    2.526984] ------------[ cut here ]------------
>>> [    2.531632] WARNING: CPU: 1 PID: 1 at kernel/locking/lockdep.c:2755
>>> lockdep_trace_alloc+0xf4/0x124()
> 
>> This fixes the warning:
> 
>> --- a/sound/soc/fsl/fsl_ssi.c
>> +++ b/sound/soc/fsl/fsl_ssi.c
>> @@ -180,7 +180,6 @@ static const struct regmap_config fsl_ssi_regconfig = {
>>         .volatile_reg = fsl_ssi_volatile_reg,
>>         .precious_reg = fsl_ssi_precious_reg,
>>         .writeable_reg = fsl_ssi_writeable_reg,
>> -       .cache_type = REGCACHE_RBTREE,
>>  };
> 
>> Is this the correct fix?
> 
> I suspect not, it looks like the driver is using the cache for
> suspend/resume handling.  I've dropped the patch for now.  Either the
> driver should explicitly write to the relevant registers outside of
> interrupt context to ensure the cache entry exists or it should keep the
> defaults and explicitly write them to hardware at startup to ensure
> sync (the former is more likely to be safe).

Is it acceptable to switch it to flat cache instead to not keep the register
defaults in driver?

Maciej
