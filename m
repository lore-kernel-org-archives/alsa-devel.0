From: Fabio Estevam <festevam@gmail.com>
Subject: Re: iMX6UL EVK with kernel 4.6
Date: Mon, 2 May 2016 09:15:06 -0300
Message-ID: <CAOMZO5BKV5YrW0aUoNwzAhM8JRZfLu=W518y3kDhD+JsTrJB8w@mail.gmail.com>
References: <50f27095-3304-03fa-7209-3f05baccb346@jikos.cz>
 <CAOMZO5BU2--_CV8FUsvkkesKGLW9NcnDPNvxC7UnK5vWwgDqVQ@mail.gmail.com>
 <CAOMZO5BGDnECdRFU6XFws9poNyF-yGJbv=io43mQgcqO4L-fbw@mail.gmail.com>
 <0721dbbe-a122-6be3-743f-669672b2c83f@jikos.cz>
 <CAOMZO5BM-EM0s5zWUmbRMkzV11Az9D+KLmQJ7dgv_RvKX9mihg@mail.gmail.com>
 <e163b954-0c4b-b859-0e15-ea113d2f5ddd@jikos.cz>
 <CAOMZO5Am7xQS556TpX5Xjk5s19CjMzH=+roY7jPhmRD25fiEvQ@mail.gmail.com>
 <3bede708-4c7c-dfae-fb26-c20a42289836@jikos.cz>
 <CAOMZO5CbtgcencL7UTk8HUmJwEd7HuLDSNNGuLA0UUn5Grxdig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f177.google.com (mail-io0-f177.google.com
 [209.85.223.177])
 by alsa0.perex.cz (Postfix) with ESMTP id C0FC4260421
 for <alsa-devel@alsa-project.org>; Mon,  2 May 2016 14:15:07 +0200 (CEST)
Received: by mail-io0-f177.google.com with SMTP id u185so193518650iod.3
 for <alsa-devel@alsa-project.org>; Mon, 02 May 2016 05:15:07 -0700 (PDT)
In-Reply-To: <CAOMZO5CbtgcencL7UTk8HUmJwEd7HuLDSNNGuLA0UUn5Grxdig@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <brain@jikos.cz>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <timur@tabi.org>
List-Id: alsa-devel@alsa-project.org

Hi Petr,

On Sun, May 1, 2016 at 5:19 PM, Fabio Estevam <festevam@gmail.com> wrote:
> On Sun, May 1, 2016 at 4:24 PM, Petr Kulhavy <brain@jikos.cz> wrote:
>
>> The controls to unmute are:
>>
>> Left Output Mixer PCM [Off]
>> Right Output Mixer PCM [Off]
>
> I don't know why, but alsamixer does not allow me to unmute thes options.

Should sound/soc/codecs/wm8960.c be changed so that thes options are
turned on by default?
