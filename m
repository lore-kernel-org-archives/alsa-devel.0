From: Fabio Estevam <festevam@gmail.com>
Subject: Re: aplay lists both Playback and Capture devices
Date: Sat, 1 Jun 2013 18:36:49 -0300
Message-ID: <CAOMZO5Cn6ANtrb675v7A90aRsS1+L7nB3RaN+vp_OJc+FROF9g@mail.gmail.com>
References: <CAOMZO5Cq8xSj3fGoZEO+K5xxJNfHotC2PiuX62q+p+yw1-i9Ng@mail.gmail.com>
 <51A736C6.2060500@ladisch.de>
 <CAOMZO5C3eDi_wicdJLab5Dg1yqexkJ6Ffhwwft_2XnO5KHPD+Q@mail.gmail.com>
 <CAOMZO5CfQUnRN8h5gSFV8qAu2YYw4B3hZRBfgkW5DzEmAb3-2A@mail.gmail.com>
 <20130601190622.GM16790@sirena.org.uk>
 <CAOMZO5BTv2oqZzwXcWs=K8r+tdzCR8MA+DuopYaBnH+fw5Hsug@mail.gmail.com>
 <20130601210534.GU16790@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ve0-f182.google.com (mail-ve0-f182.google.com
 [209.85.128.182])
 by alsa0.perex.cz (Postfix) with ESMTP id A940F261B35
 for <alsa-devel@alsa-project.org>; Sat,  1 Jun 2013 23:36:50 +0200 (CEST)
Received: by mail-ve0-f182.google.com with SMTP id ox1so2015332veb.27
 for <alsa-devel@alsa-project.org>; Sat, 01 Jun 2013 14:36:49 -0700 (PDT)
In-Reply-To: <20130601210534.GU16790@sirena.org.uk>
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
Cc: =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On Sat, Jun 1, 2013 at 6:05 PM, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Jun 01, 2013 at 04:20:50PM -0300, Fabio Estevam wrote:
>
>> What is the proper way to know this information?
>
>> Or how do I tell that each DAI is unidirectional?
>
> If it's not got any playback or capture capabilities.

On mx28evk there are two DAIs connected to a single sgtl5000:

- One corresponds to the serial audio interface 0 (SAIF0) and it is
playback only

- The other corresponds to the serial audio interface 1 (SAIF1) and it
is capture only.

Should I create and pass device tree bindings like "playback-only" and
"capture-only", so that we can avoid having both playback and capture
capabilities for SAIF0 and SAIF1?

Or is there already a mechanism in place that I can use to configure a
DAI as unidirectional?

Thanks,

Fabio Estevam
