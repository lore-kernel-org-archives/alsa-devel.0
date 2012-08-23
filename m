From: George Stefan <stefan.george87@gmail.com>
Subject: Re: SAIF configuration on imx28
Date: Thu, 23 Aug 2012 16:09:22 +0300
Message-ID: <CAACwSTLzfm5Pdw8y6P5MqOT_W3XChdm+tG9EP0zYmQF1Rb-mxg@mail.gmail.com>
References: <CAACwSTK-fzSy+HG+u5H0aNU_wfSa7gvAsH2fVMdczssnYtpJXw@mail.gmail.com>
 <CAOMZO5C9ezzU7S0M-AN0f8gk7SBWs3WNbA6cG2S+7BF8j+dVxA@mail.gmail.com>
 <CAACwSTKiN17gAHnUs5BoHZH_K5NNo0z7X9QbVRFu9FZGCUw2mg@mail.gmail.com>
 <CAACwST+=owJQ+KGAKYLgpGY4k1hGNSC4ptSGMyVObSRpUightQ@mail.gmail.com>
 <CAOMZO5BGiU7J6W8TSybe8ELqnfLD=SYf9c_uVz6ppb4E2MOnzw@mail.gmail.com>
 <CAACwSTKkNFw9kC54VJ8en+tWpO9vpnHsszfyDtufWDeWhZCY5Q@mail.gmail.com>
 <20120823064844.GD10057@shlinux2.ap.freescale.net>
 <CAACwSTLLKCKj8rOfvqVZ5zCBTCUaFEJMEeA3oNBgnQRHFtciKQ@mail.gmail.com>
 <20120823074617.GI10057@shlinux2.ap.freescale.net>
 <CAACwSTL4MG3opgQTve9k1nt1eZbpTJcn7Fw84GQufW8+J-qg3Q@mail.gmail.com>
 <CAACwST+DAEd_8rVV14WBVFikCt5ed=KZnF6W43BJ9tnXDA6Z4w@mail.gmail.com>
 <CAOMZO5BV_j1P4x3_niyZ3XqjnJGwR_b0aagyArHsFq_iEFy5sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 92C47266547
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 15:09:22 +0200 (CEST)
Received: by eeke50 with SMTP id e50so215528eek.38
 for <alsa-devel@alsa-project.org>; Thu, 23 Aug 2012 06:09:22 -0700 (PDT)
In-Reply-To: <CAOMZO5BV_j1P4x3_niyZ3XqjnJGwR_b0aagyArHsFq_iEFy5sg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Dong Aisheng <b29396@freescale.com>, Lauri Hintsala <lauri.hintsala@bluegiga.com>
List-Id: alsa-devel@alsa-project.org

2012/8/23 Fabio Estevam <festevam@gmail.com>

> On Thu, Aug 23, 2012 at 9:54 AM, George Stefan
> <stefan.george87@gmail.com> wrote:
>
> > I test record with:
> > arecord -d 5 -f S16_LE -r 8000 -c 2 1.wav
> >
> > Dump for 1.wav
> > exdump -C 1.wav
>
> Does this wav file have good data?
>
That is my main problem. I have a modem...which is a "black box" and i am
not sure if
it is emitting valid data. I just configure an audio loop on the modem side.
If i play this on my laptop, its just a spike...at the begining and then
silence.
