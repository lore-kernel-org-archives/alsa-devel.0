From: noman pouigt <variksla@gmail.com>
Subject: Re: [PATCH v2 8/8] ASoC: dapm: Use more aggressive
	caching
Date: Sun, 26 Oct 2014 12:29:30 -0700
Message-ID: <CAES_P+8Z2BO46XuLokSXsgfNQud3VfNTXKOno9VinTsM=cyXBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f53.google.com (mail-oi0-f53.google.com
 [209.85.218.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 097962605DA
 for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 20:29:34 +0100 (CET)
Received: by mail-oi0-f53.google.com with SMTP id v63so2394823oia.40
 for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 12:29:31 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

>E.g. imagine the following example:
>
>        A --> B ----.
>                    v
>       M --> N --> Z <-- S <-- R
>                    |
>                    v
>                    X>
>
>Widget Z has multiple input paths, if any change was made that cause Z to be
>marked as dirty the power state of Z has to be re-computed. This requires to
>know the number of inputs and outputs of Z, which requires to know the
>number of inputs and outputs of all widgets on all paths from or to Z.
>Previously this meant re-computing all inputs and outputs of all the path
>going into or out of Z. With this patch in place only paths that actually
>have changed need to be re-computed.
so suppose "B" was the widget which caused "Z" to be dirtied then with your
patch only you will calculate A->B->N->Z ?

Is my understanding right?

A->B->C
            |
            v
           G->P
            v
            |
D->E->F

What will happen in the above diagram if P gets dirtied?
