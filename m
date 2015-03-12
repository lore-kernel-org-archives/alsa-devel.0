From: Belisko Marek <marek.belisko@gmail.com>
Subject: Re: dummy codec + simple card combination
Date: Thu, 12 Mar 2015 19:33:23 +0100
Message-ID: <CAAfyv36tTpvWgrKaMySdfYnBcoSAr64NzAH6fCsNt2MN5PX3wg@mail.gmail.com>
References: <CAAfyv37dgX=6aBYH4FWuJgh=k4jQB1Osh_3fwJhRU5unt6Bd6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f178.google.com (mail-wi0-f178.google.com
 [209.85.212.178])
 by alsa0.perex.cz (Postfix) with ESMTP id A9F932605E4
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 19:33:23 +0100 (CET)
Received: by wiwh11 with SMTP id h11so74334wiw.1
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 11:33:23 -0700 (PDT)
In-Reply-To: <CAAfyv37dgX=6aBYH4FWuJgh=k4jQB1Osh_3fwJhRU5unt6Bd6A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, jarkko.nikula@bitmer.com, lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: alsa-devel@alsa-project.org

Hi,

I posted same question on alsa-devel ML this week but I forgot to add
sound omap + asoc maintainers (sorry about that)

I'm trying to add audio support for gta04 (for gsm + bt and fm audio).
All audio sources are clock masters so basically connection is dummy
codecs -> cpu dai (mcbsp ports).

For implementing such thing I can see 2 options:
1. simple card driver which can easily describe cpu dai interface but
dummy codec cannot because there are no DT bindings (there was sever
attempts to add DT bindings for dummy-codec but AFAIK none was
accepted)

This turns it to only solution to create gta04 soundcard which will
get from DT cpu dai links and use in card driver dummy codecs
directly.

Is my assumption correct? I would like to get some feedback before
wasting my time with implementing something which cannot be pushed
mainline. Thanks for all suggestions.

BR,

marek

--
as simple and primitive as possible
-------------------------------------------------
Marek Belisko - OPEN-NANDRA
Freelance Developer

Ruska Nova Ves 219 | Presov, 08005 Slovak Republic
Tel: +421 915 052 184
skype: marekwhite
twitter: #opennandra
web: http://open-nandra.com
