From: Mathias Krause <minipli@googlemail.com>
Subject: Re: [PATCH 0/4] ASoC: constification patches
Date: Mon, 15 Jun 2015 19:59:30 +0200
Message-ID: <CA+rthh9Lbqwmc4o9Qbx4gZz-OSmuCY275YXdkmumwQxugkENtQ@mail.gmail.com>
References: <1434198316-8400-1-git-send-email-minipli@googlemail.com>
 <20150615103238.GI18309@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 61B2F265289
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 19:59:30 +0200 (CEST)
Received: by wgv5 with SMTP id 5so75021642wgv.1
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 10:59:30 -0700 (PDT)
In-Reply-To: <20150615103238.GI18309@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 15 June 2015 at 12:32, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Jun 13, 2015 at 02:25:12PM +0200, Mathias Krause wrote:
>> Hi Liam, Mark,
>>
>> this series constifies a few variables in the SoC code that are only
>> read, namely struct reg_default and struct acpi_device_id.
>
> Applied, but again please make an effort to use relevant CC lists for
> patches.

Sorry, actually I tried to. It's what get_maintainer.pl told me but I
tried to trim down the list because of the simpleness of the patches.
I omitted LKML to avoid cross-posting. I messed up patches 2 and 3,
admitted. But what else was wrong?

Regards,
Mathias
