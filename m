From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: soc-io: Only force use regmap if the
 codec have it implemented
Date: Wed, 01 Aug 2012 15:20:29 +0300
Message-ID: <50191F0D.6090807@ti.com>
References: <1343822505-6331-1-git-send-email-peter.ujfalusi@ti.com>
 <20120801121630.GP11892@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
 [74.125.149.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 1DAE9265279
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 14:19:39 +0200 (CEST)
Received: by ggnc4 with SMTP id c4so7156593ggn.3
 for <alsa-devel@alsa-project.org>; Wed, 01 Aug 2012 05:19:40 -0700 (PDT)
In-Reply-To: <20120801121630.GP11892@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 08/01/2012 03:16 PM, Mark Brown wrote:
> On Wed, Aug 01, 2012 at 03:01:45PM +0300, Peter Ujfalusi wrote:
> =

>>  	case SND_SOC_REGMAP:
>>  		/* Device has made its own regmap arrangements */
>> -		codec->using_regmap =3D true;
> =

> No, this is crazy.

Why?
We set it when we have confirmed that the codec actually have regmap of it'=
s own.

-- =

P=E9ter
