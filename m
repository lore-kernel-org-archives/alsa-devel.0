From: Subodh Chiwate <subodh.austin@gmail.com>
Subject: Re: HDA jack retask for Debian 7.4 NOT working
Date: Wed, 12 Mar 2014 12:42:24 +0530
Message-ID: <CAAh=20Qqkj0mV4G_fZZvaVysh5NaRPxqk=megHpCfWttzwEiQA@mail.gmail.com>
References: <CAAh=20RH3jg+W0PQOnu2NU+HPVpp9GT=ZOnd46PZr4mgweGJJg@mail.gmail.com>
 <CAN8cciYkcwtOv17kFxNsPXXoye=P3yk4d5YbCoSbQYk_6+R0ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f48.google.com (mail-pb0-f48.google.com
 [209.85.160.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 662A1260307
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 08:12:46 +0100 (CET)
Received: by mail-pb0-f48.google.com with SMTP id md12so691371pbc.7
 for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2014 00:12:45 -0700 (PDT)
In-Reply-To: <CAN8cciYkcwtOv17kFxNsPXXoye=P3yk4d5YbCoSbQYk_6+R0ng@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-user@lists.sourceforge.net, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

As suggested, I installed the latest drivers for my sound card from vendor
and the jack reroute changes did take effect.
Thanks a lot.



On Tue, Mar 11, 2014 at 4:55 PM, Raymond Yau <superquad.vortex2@gmail.com>wrote:

>  > Hi,
> > I am trying to get surround 7.1 on debian 7.4 Wheezy.
> > As guided by hda-jack-retask readme I built it from source on my system.
> > But the changes are not reflecting and no errors by utility as well.
> >
> > I am getting Alsa 1.0.25 from the repository.
>
> You need alsa driver 1.0.27 or later which hda driver use auto generic
> parser instead of using static quirk if you need retasking headphone to
> side line out
>
> > Do I need to build the latest version from source to get hdajackretask
> as part of alsa-tools ?
> > Any other suggestions to get the 7.1 working are welcome.
>
>
> https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/tree/Documentation/sound/alsa/HD-Audio.txt
>
> hdajackretask just a GUI program to create a firmware file for fixup
> pincfg by early patching
>



-- 
Regards
Subodh
