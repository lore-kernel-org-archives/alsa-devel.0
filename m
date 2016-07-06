From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: nau8825: jack connection decision
 with different insertion logic
Date: Tue, 5 Jul 2016 19:54:46 -0700
Message-ID: <CAOMFOmUpZOM9+vOZi29jxsdV8zaCH+z4036dot37-yynPu8L3g@mail.gmail.com>
References: <1467170438-5157-1-git-send-email-KCHSU0@nuvoton.com>
 <CAOMFOmUhvWrm6ivTs4Ujp2_A8o81A12L0gPUDay0Bv9PVAkbug@mail.gmail.com>
 <5774CF97.4010203@nuvoton.com> <20160701155734.GV6247@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f45.google.com (mail-oi0-f45.google.com
 [209.85.218.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 24517261A3D
 for <alsa-devel@alsa-project.org>; Wed,  6 Jul 2016 04:54:48 +0200 (CEST)
Received: by mail-oi0-f45.google.com with SMTP id u201so254620144oie.0
 for <alsa-devel@alsa-project.org>; Tue, 05 Jul 2016 19:54:48 -0700 (PDT)
In-Reply-To: <20160701155734.GV6247@sirena.org.uk>
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
Cc: AP MS30 Linux ALSA <alsa-devel@alsa-project.org>, AC30 YHChuang <YHCHuang@nuvoton.com>, John Hsu <KCHSU0@nuvoton.com>, Liam Girdwood <lgirdwood@gmail.com>, Ben Zhang <benzh@chromium.org>, AC30 CTLin0 <CTLIN0@nuvoton.com>, MS40 MHKuo <MHKuo@nuvoton.com>, Yong Zhi <yong.zhi@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi

On Fri, Jul 1, 2016 at 8:57 AM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jun 30, 2016 at 03:51:51PM +0800, John Hsu wrote:
>
>> Yes, it'll be more readable. I have a question. Why to add !! in
>> front of bit wise operation? What does it mean?
>
> It's redundant in almost all cases.  It translates an integer value
> into a 0/1 value (so if you've got a value of 2 it'll end up as 1) by
> doing a double not.  This very rarely matters unless you're storing the
> value in an integer and comparing it to 1 to check for truth, otherwise
> C will translate any non-zero value into true in any logic context.

Thanks Mark for the comment. I added "!!" by following my muscle
memory. That how I used to convert non-bools to bool.

But your comment forced me to research this question. C99 and C11
standards clarify this issue
http://port70.net/~nsz/c/c11/n1570.html#6.3.1.2p1

..<QUOTE>..
  When any scalar value is converted to _Bool, the result is 0 if the
value compares equal to 0; otherwise, the result is 1


It is safe to drop "!!" idiom completely - compiler will take care of
converting the result of bitmask to a proper bool value. My example
above can be overwritten as
      bool active_high = jkdet & NAU8825_JACK_POLARITY;
      bool is_high = status & NAU8825_GPIO2JD1;
      return active_high == is_high;
