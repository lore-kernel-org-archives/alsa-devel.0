From: Ran Shalit <ranshalit@gmail.com>
Subject: Re: [Alsa-user] 'control ... is already present'
	message
Date: Sat, 12 Sep 2015 20:03:17 +0300
Message-ID: <CAJ2oMhJB+my+5Mu2Dez4M26mct+RGG-mkRSC5-0ZavnJ35+yTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f171.google.com (mail-ig0-f171.google.com
 [209.85.213.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 60130260589
 for <alsa-devel@alsa-project.org>; Sat, 12 Sep 2015 19:03:19 +0200 (CEST)
Received: by igcpb10 with SMTP id pb10so65158548igc.1
 for <alsa-devel@alsa-project.org>; Sat, 12 Sep 2015 10:03:18 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@googlemail.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 11, 2015 at 9:42 AM, Clemens Ladisch
<cladisch@googlemail.com> wrote:
> Ran Shalit wrote:
>> asoc: failed to add dapm kcontrol Right HPCOM Mixer Line2L Bypass Switch: -16
>> asoc: failed to add kcontrol Right Line2R Mux
>> ...
>> What is the reason for the "asoc: failed to add dapm kcontrol" and the
>> " 'control ... already present" messeges ?
>
> That there are two controls with the same name and index.
>
>> If I move each to be registered to its own card will it resolve this issue ?
>
> Probably, but a better idea might be to set index=1 for all controls of the
> second codec.  I don't know how ASoC handles this; ask on the alsa-devel
> list.
>
>
> Regards,
> Clemens

Hi Clemens,

Can you please add how to set index=1 to second codec ?

Thank you,
Ran
