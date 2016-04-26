From: anish kumar <yesanishhere@gmail.com>
Subject: Re: [PATCH] ASoC: Add max98371 codec driver
Date: Tue, 26 Apr 2016 11:16:38 -0700
Message-ID: <CABCoZhCv0u72vDHkEbq--SuHcZGvQYggH9EbSSYLC3ByFdt-cA@mail.gmail.com>
References: <1460578847-8712-1-git-send-email-yesanishhere@gmail.com>
 <20160418164727.GI3217@sirena.org.uk>
 <CABCoZhDLyT_2xMhOqkiw5+9rOtA9FUqcvxy+1Pz=2QohAZEcHA@mail.gmail.com>
 <20160419094629.GP3217@sirena.org.uk>
 <CABCoZhAXqXTdMebSHLXTMbAUYCR-8H320F_0EOViYcGqMwisWQ@mail.gmail.com>
 <20160422153124.GH3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f194.google.com (mail-qk0-f194.google.com
 [209.85.220.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F67C26154F
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 20:16:39 +0200 (CEST)
Received: by mail-qk0-f194.google.com with SMTP id l68so1558066qkf.3
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 11:16:39 -0700 (PDT)
In-Reply-To: <20160422153124.GH3217@sirena.org.uk>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 22, 2016 at 8:31 AM, Mark Brown <broonie@kernel.org> wrote:
> On Wed, Apr 20, 2016 at 11:14:40AM -0700, anish kumar wrote:
>> On Tue, Apr 19, 2016 at 2:46 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > Hrm, that looks like the driver may be able to set it automatically
>> > using the regulator API and just have a switch for the guaranteed.
>
>> Should i pass it via device tree then? I didn't get your statement about
>
> I'd expect to look up the value by looking at the supply voltage if we
> were going to go that way.

Discussion of this with hardware team revealed that dynamic headroom
tracking is the feature which will be controlled with this gain.

I am also adding two new controls for this: speaker gain min and DHT
rotation point.

I will be adding all of this as TLV as this should be configurable.
>
>> "switch".
>
> A switch is an on/off control.
