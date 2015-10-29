From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Getting channel slips with fsl_ssi.c in
 TDM (network) mode.
Date: Thu, 29 Oct 2015 12:08:42 -0700
Message-ID: <CAG5mAdze1bT5ZDK8k9UM_jMhf_3sENJ7_9L133WorSBaoEfk0w@mail.gmail.com>
References: <CAG5mAdxDmh3XDZSSHb8Oa7s-rosdVvTZPqu2zyDC42rMcqxxHA@mail.gmail.com>
 <CAG5mAdwC00qbu9zMHKjx5JZX_2CobBo81+jtpsWGPHPQ0jKX0A@mail.gmail.com>
 <20151027071344.GC25728@pengutronix.de> <20151027201101.GA9527@Asurada-CZ80>
 <CAG5mAdz=TKSmXBOqKfSj0FYfk3c6syBa87OazyGRRF0NU4snXA@mail.gmail.com>
 <20151029045350.GA3374@Asurada-CZ80>
 <CAG5mAdwQd3ep7ZSNHDEni6caKeFPyvXhM0g=BjqPFA_gDSU1DQ@mail.gmail.com>
 <CAG5mAdw220n3K8vfRAgixxeYa=rBp5YbOrn_8ecwH+KN0JOnnA@mail.gmail.com>
 <56323D3F.4080708@tekno-soft.it>
 <CAG5mAdywpA1af60wTwgPWMPGWmz7cYDHOycbSUeWHF3Znyr78w@mail.gmail.com>
 <20151029183617.GC3492@Asurada-CZ80>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 6865526170F
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 20:09:02 +0100 (CET)
Received: by wmff134 with SMTP id f134so30051316wmf.1
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 12:09:02 -0700 (PDT)
In-Reply-To: <20151029183617.GC3492@Asurada-CZ80>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Markus Pargmann <mpa@pengutronix.de>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 29, 2015 at 11:36 AM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> On Thu, Oct 29, 2015 at 08:54:00AM -0700, Caleb Crome wrote:
>
>> The 35 and 36 are for Dual fifo mode only, and no current system (with
>> fsl_ssi.c anyway) uses dual fifo mode.  How do I know?  Because the
>> it's definitely broken in the fsl_ssi.c.  I was just about to report
>> that bug.
>
> Broken? Where?

Sorry, my bad, the only broken part was my understanding :-)  I
discovered that a few minutes after I posted the comment.
