From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: rockchip rk3288 registration
Date: Tue, 28 Jul 2015 16:00:14 +0200
Message-ID: <CAOf5uwmPcD5cMUiiCPuP_jqcm1ebmfdmRdB1Mq=igW2X=2o7VQ@mail.gmail.com>
References: <CAOf5uwnkXjuMhfkos3kMzz1unRWv3mrc5eeB6+roFM5RoGGTgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f41.google.com (mail-la0-f41.google.com
 [209.85.215.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 8998826578E
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 16:00:14 +0200 (CEST)
Received: by lahh5 with SMTP id h5so69104381lah.2
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 07:00:14 -0700 (PDT)
In-Reply-To: <CAOf5uwnkXjuMhfkos3kMzz1unRWv3mrc5eeB6+roFM5RoGGTgA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, jay.xu@rock-chips.com
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all

On Tue, Jul 28, 2015 at 3:34 PM, Michael Trimarchi
<michael@amarulasolutions.com> wrote:
> Hi
>
> I have created a simple sound card to test registration on i2s but I
> have some problems
> that after a while in SND_SOC_DAIFMT_CBM_CFM the device stop to register and
> receive a input/output error. It means that I can not receive anymore
> from the device
>
> arecord -c 2 -r 96000 -f S32_LE -D hw:0 > record.pcm
> Recording WAVE 'stdin' : Signed 32 bit Little Endian, Rate 96000 Hz, Stereo
> arecord: pcm_read:2031: read error: Input/output error
>
> The result size is a bit random. I have no problem on playback until
> now. Any idea?
>

Is there any available documentation on I2S register settings?

Michael

> Michael



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
