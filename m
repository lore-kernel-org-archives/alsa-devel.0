From: Belisko Marek <marek.belisko@gmail.com>
Subject: dummy codec + simple card combination
Date: Tue, 10 Mar 2015 21:35:46 +0100
Message-ID: <CAAfyv37dgX=6aBYH4FWuJgh=k4jQB1Osh_3fwJhRU5unt6Bd6A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f173.google.com (mail-we0-f173.google.com
 [74.125.82.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 030E02605A2
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 21:35:47 +0100 (CET)
Received: by wesw62 with SMTP id w62so4580845wes.0
 for <alsa-devel@alsa-project.org>; Tue, 10 Mar 2015 13:35:46 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: alsa-devel@alsa-project.org

Hi,

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
