From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: ASoC: fsl_sai: Has anybody attempted to run the
 i.MX6UL in TDM mode with channels > 2?
Date: Wed, 18 Jan 2017 19:43:26 +0100
Message-ID: <20170118184326.cokht5tfy24hpf7d@piout.net>
References: <CAG5mAdy8BbeKdh+yM8vqNEU1RpzfqD20+SxQj-2iLihXxF7Mww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 214D22667FE
 for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2017 19:44:19 +0100 (CET)
Content-Disposition: inline
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Arnaud Mouiche <arnaud.mouiche@invoxia.com>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi Caleb,

Fabio pointed to that thread because I'm trying to use the i.mx7d SAI in
TDM mode with 8 channels (but I'm using only 4).

On 02/05/2016 at 10:52:39 -0700, Caleb Crome wrote :
> Hi all,
>    Now that the MX6 fsl_ssi seems to be getting stable for TDM with
> channels > 2 (thanks all!), the MX6 UL and MX7 have only the SAI port.
> 
> Does anybody have experience with running the SAI with more than 2 channels?
> 

I have a really small patch to make the SAI driver configure CR4 and CR5
properly for more than 2 channels.
Data on the TDM bus seems fine.

However, I have an issue with the sample ordering. Discussing that with
Lars, it seems the SDMA is getting confused when switching periods. To
test, I'm playing a 441Hz sine that is fading out. I can definitively
see block of 1024 samples (it is period_size) that are ok but not
properly ordered. You can have a look at:
http://free-electrons.com/~alexandre/playback.png

Did you have the same issue?

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
