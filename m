From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH v2- ALSA 1/3] HDA - Allow hda_jack_tbl to
 use another nid for pin sense
Date: Wed, 14 Oct 2015 07:35:51 +0800
Message-ID: <CAN8ccia8sgSfZxDtFTy1Qf3zCq=eov_8Fm8AfvAwJ1v1f4rqAw@mail.gmail.com>
References: <CAN8cciYNotgS=1qis4ciOQqoYwjND4y=tpxJGmZt1HGahTV3+Q@mail.gmail.com>
 <s5hvbb16yup.wl-tiwai@suse.de>
 <CAN8cciZ0HKP+RNRRsbNXpo0azmqBKBjejXJRwx8PRuHiw3pZ9w@mail.gmail.com>
 <s5h4mik6xwi.wl-tiwai@suse.de>
 <CAN8cciZ1xbRQg3aYKjDSq5K1eL44fFKZJdq52WP2Uht_A8JFDA@mail.gmail.com>
 <CALUcmUno7vKTU-45=+6spkbBbp671NiDhu2Oj4RVbNWLQYGoLw@mail.gmail.com>
 <CAN8ccia0OSv8Nyx-jUF+LneVaAcf80SwxvfA3Btdx5cqxEg2CQ@mail.gmail.com>
 <CALUcmU=DRvSEmvGNCfDc0dVHRQ9TmnK0U=094E64Sc5wxsAV5g@mail.gmail.com>
 <CALUcmUkCaBvobO85Amw5VTLTU490UsB+yg20eNdP_AAyO_e4kg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f169.google.com (mail-ob0-f169.google.com
 [209.85.214.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 50B1F265CA8
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2015 01:35:53 +0200 (CEST)
Received: by obbda8 with SMTP id da8so26925838obb.1
 for <alsa-devel@alsa-project.org>; Tue, 13 Oct 2015 16:35:51 -0700 (PDT)
In-Reply-To: <CALUcmUkCaBvobO85Amw5VTLTU490UsB+yg20eNdP_AAyO_e4kg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arthur Borsboom <arthurborsboom@gmail.com>, pellegrin.fabio@gmail.com
Cc: Takashi Iwai <tiwai@suse.de>, jason.braddock.69@gmail.com, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> Do you need more testing on the Asus N751JK by me?
> Do you need help from other developers?

Do all speakers of quad speaker array work as expected ?

If ASUS N550LF can use headset by default, it is strange that your N750JK
need any modification for the headset mic pin since they are using same
codec ALC668 with similar BIOS pin default, quad speaker array and Sonic
Master Subwoofer

If you only test CTIA headset, it is better to name the model according to
what you have tested
