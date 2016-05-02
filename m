From: Fabio Estevam <festevam@gmail.com>
Subject: Re: ASoC: fsl_sai: Has anybody attempted to run the
 i.MX6UL in TDM mode with channels > 2?
Date: Mon, 2 May 2016 19:41:24 -0300
Message-ID: <CAOMZO5CrRD+krtvMxpq=XPSzDC0sx-+j1tbBQG=Qy=e_z3oKig@mail.gmail.com>
References: <CAG5mAdy8BbeKdh+yM8vqNEU1RpzfqD20+SxQj-2iLihXxF7Mww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f181.google.com (mail-io0-f181.google.com
 [209.85.223.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 50B39260438
 for <alsa-devel@alsa-project.org>; Tue,  3 May 2016 00:41:25 +0200 (CEST)
Received: by mail-io0-f181.google.com with SMTP id 190so6480146iow.1
 for <alsa-devel@alsa-project.org>; Mon, 02 May 2016 15:41:25 -0700 (PDT)
In-Reply-To: <CAG5mAdy8BbeKdh+yM8vqNEU1RpzfqD20+SxQj-2iLihXxF7Mww@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Caleb Crome <caleb@crome.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>
List-Id: alsa-devel@alsa-project.org

Hi Caleb,

On Mon, May 2, 2016 at 2:52 PM, Caleb Crome <caleb@crome.org> wrote:
> Hi all,
>    Now that the MX6 fsl_ssi seems to be getting stable for TDM with
> channels > 2 (thanks all!), the MX6 UL and MX7 have only the SAI port.

Yes, great job from you and Arnaud :-)

> Does anybody have experience with running the SAI with more than 2 channels?
>
> Any thoughts or comments would be welcome!

All the boards I have with SAI have only stereo codecs (sgtl5000,
wm8960, wm8962).
