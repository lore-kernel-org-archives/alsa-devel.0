From: Fabio Estevam <festevam@gmail.com>
Subject: Re: i.MX6Q no audio with wm8962 Question
Date: Wed, 18 Jul 2018 16:13:42 -0300
Message-ID: <CAOMZO5DGEQXaP8RVHuKHfLANErR4g+LS3Xu4HaCRZE=QhWk5dQ@mail.gmail.com>
References: <CAHCN7xLtV=wQuhorEi-BH_Ofk1bXexb33xZyF8R=QC61aciLhw@mail.gmail.com>
 <CAHCN7x+7MGRR+4tr22kMFxbaqOjKFh-mWz4iqpVRPQ72wiAF9w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
 [209.85.218.53])
 by alsa0.perex.cz (Postfix) with ESMTP id DC53F2677A0
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2018 21:13:44 +0200 (CEST)
Received: by mail-oi0-f53.google.com with SMTP id y207-v6so10853820oie.13
 for <alsa-devel@alsa-project.org>; Wed, 18 Jul 2018 12:13:44 -0700 (PDT)
In-Reply-To: <CAHCN7x+7MGRR+4tr22kMFxbaqOjKFh-mWz4iqpVRPQ72wiAF9w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Adam Ford <aford173@gmail.com>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Brad Brown <brad.brown@logicpd.com>, Linux-ALSA <alsa-devel@alsa-project.org>, arm-soc <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Adam,

On Wed, Jul 18, 2018 at 1:07 PM, Adam Ford <aford173@gmail.com> wrote:
> On Tue, Jul 17, 2018 at 2:40 PM Adam Ford <aford173@gmail.com> wrote:
>>
>> I have an iMX6Q with a wm8962 attached using AUDMUX4 and SSI2, but I
>> am having difficulty getting the sound to generate from the headphone
>> jack.
>
> sorry for the noise.  It turns out to be a faulty pull-up resistor on
> the I2C bus
>
> it's working

Glad you fixed the problem :-)
