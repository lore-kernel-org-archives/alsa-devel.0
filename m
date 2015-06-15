From: Mathias Krause <minipli@googlemail.com>
Subject: Re: [PATCH 2/4] ASoC: rt5640: Constify ACPI device ids
	and register map
Date: Mon, 15 Jun 2015 19:50:00 +0200
Message-ID: <CA+rthh_s_rFbTbo3vHybdmch1F2WY=mS=sgUcA9dCV+Zm1UdCA@mail.gmail.com>
References: <1434198316-8400-1-git-send-email-minipli@googlemail.com>
 <1434198316-8400-3-git-send-email-minipli@googlemail.com>
 <20150615101940.GH18309@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 by alsa0.perex.cz (Postfix) with ESMTP id EE46B26520E
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 19:50:00 +0200 (CEST)
Received: by wibdq8 with SMTP id dq8so86495982wib.1
 for <alsa-devel@alsa-project.org>; Mon, 15 Jun 2015 10:50:00 -0700 (PDT)
In-Reply-To: <20150615101940.GH18309@sirena.org.uk>
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
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liam Girdwood <lgirdwood@gmail.com>, Len Brown <lenb@kernel.org>
List-Id: alsa-devel@alsa-project.org

On 15 June 2015 at 12:19, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Jun 13, 2015 at 02:25:14PM +0200, Mathias Krause wrote:
>> Constify the ACPI device ID array and the register map, no need to have
>> them writable at runtime. Also drop the unneeded RT5640_INIT_REG_LEN
>> define.
>>
>> Signed-off-by: Mathias Krause <minipli@googlemail.com>
>> Cc: Bard Liao <bardliao@realtek.com
>> Cc: Oder Chiou <oder_chiou@realtek.com>
>
> Please don't include stuff like this in the commit log if you're not
> using it - you've CCed Oder but not Bard here (you should be CCing him).

Sorry, I messed it up! I relied in 'git send-email' to add the
required Cc's but due to the missing closing bracket Bard was skipped.
Sorry. Will take more care next time!

Thanks,
Mathias
