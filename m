From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v3 0/6] ASoC: fsl_ssi: Fixing various
 channel slips and bad samples insertions
Date: Fri, 29 Apr 2016 09:49:44 -0700
Message-ID: <CAG5mAdwFd3avEv6Tup9F0YcmtTQAFgHa2oF6FzjeLaZnonpomA@mail.gmail.com>
References: <1453130771-24419-1-git-send-email-arnaud.mouiche@invoxia.com>
 <CAOMZO5A0FRZ52UGeqLJaVF8BiWhzmpNSgQm4B0U1gc2wGU6KhA@mail.gmail.com>
 <20160429035402.GB1944@Asurada>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f50.google.com (mail-oi0-f50.google.com
 [209.85.218.50])
 by alsa0.perex.cz (Postfix) with ESMTP id A4C73261483
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2016 18:50:05 +0200 (CEST)
Received: by mail-oi0-f50.google.com with SMTP id k142so125035904oib.1
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2016 09:50:05 -0700 (PDT)
In-Reply-To: <20160429035402.GB1944@Asurada>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 28, 2016 at 8:54 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Fri, Apr 29, 2016 at 12:44:16AM -0300, Fabio Estevam wrote:
>> Hi Nicolin and Timur,
>>
>> On Mon, Jan 18, 2016 at 1:26 PM, Arnaud Mouiche
>> <arnaud.mouiche@invoxia.com> wrote:
>> >
>> > This series of patch is an attempt to fix the fsl_ssi driver to use it in TDM mode (DSP A or B) with a large number of channels/slots.
>>
>> Any feedback about this series?
>>
>> It addresses important fixes for the fsl_ssi driver.
>
> Patches look fine to me. I thought there was going to be another version.

There is another patch that comes after these, but that's relating the
the watermark issues we talked about before.  The watermark issues can
stand independently of this patch series, so I think it's best to keep
the complexity with watermarks separate this series.    Arnaud never
mentioned to me that there was a version after v3.

-Caleb

>
> Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
