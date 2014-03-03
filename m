From: Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH v4-resend 1/7] ASoC: sirf: Add SiRF
 internal audio codec driver
Date: Mon, 3 Mar 2014 15:48:02 +0800
Message-ID: <CAGsJ_4xjCsVuySJdarevvJ5qgMxKFNyDZi_nb_Gh6+DBd4uKrQ@mail.gmail.com>
References: <1393399342-31177-1-git-send-email-rongjun.ying@csr.com>
 <1393399342-31177-2-git-send-email-rongjun.ying@csr.com>
 <20140227053339.GU9383@sirena.org.uk>
 <86130EF012BDF348AA0D464A4F449478012AE51755@SHAASIEXM01.ASIA.ROOT.PRI>
 <20140301031646.GJ29849@sirena.org.uk>
 <86130EF012BDF348AA0D464A4F449478012AE52440@SHAASIEXM01.ASIA.ROOT.PRI>
 <20140303050745.GP2411@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 85F752655DB
 for <alsa-devel@alsa-project.org>; Mon,  3 Mar 2014 08:48:23 +0100 (CET)
Received: by mail-pd0-f181.google.com with SMTP id p10so3381585pdj.40
 for <alsa-devel@alsa-project.org>; Sun, 02 Mar 2014 23:48:22 -0800 (PST)
In-Reply-To: <20140303050745.GP2411@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>, Rongjun Ying <Rongjun.Ying@csr.com>, RongJun Ying <rjying@gmail.com>
List-Id: alsa-devel@alsa-project.org

2014-03-03 13:07 GMT+08:00 Mark Brown <broonie@kernel.org>:
> On Mon, Mar 03, 2014 at 02:15:17AM +0000, Rongjun Ying wrote:
>
>> The codec clock is only used by this driver. And this clock is not managed by
>> clock controller. The Audio controller codec is always enable. So I think
>> it is not need abstract to general clock API.
>
> No, you're still missing the point.  You are requesting external clocks,
> why are you not managing those here?
Hi Mark,
here the clock is an internal clock in the internal codec. the
external clock of audio controller is managed in system suspend/resume
as you see. but they are not managed in runtime suspend/resume here
because the external clock is always enabled to make sure the charge
pump to be working to make the board have stable current and voltage.
otherwise, touchscreen ADC will not be accurate.

>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

-barry
