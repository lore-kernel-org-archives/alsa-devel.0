From: Leon Romanovsky <leon@leon.nu>
Subject: Re: [PATCH 2/8] ASoC: alc5632: Use params_width()
 rather than memory format
Date: Fri, 10 Jan 2014 15:44:43 +0200
Message-ID: <CALq1K=Ln8J-kh--QLZMYNLDNQLegGBFgpJ1LeEqon39y-QjJRQ@mail.gmail.com>
References: <1389210723-16535-1-git-send-email-broonie@kernel.org>
 <1389210723-16535-2-git-send-email-broonie@kernel.org>
 <CALq1K=Kss-NUYB-mmhOjCbxSjhaRO62GpnY95rFMzruo35i=fw@mail.gmail.com>
 <20140109103316.GD31886@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f51.google.com (mail-vb0-f51.google.com
 [209.85.212.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F65B260857
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 14:45:04 +0100 (CET)
Received: by mail-vb0-f51.google.com with SMTP id 10so1458892vbe.38
 for <alsa-devel@alsa-project.org>; Fri, 10 Jan 2014 05:45:03 -0800 (PST)
In-Reply-To: <20140109103316.GD31886@sirena.org.uk>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, linaro-kernel@lists.linaro.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 9, 2014 at 12:33 PM, Mark Brown <broonie@kernel.org> wrote:
> On Thu, Jan 09, 2014 at 06:55:17AM +0200, Leon Romanovsky wrote:
>> On Wed, Jan 8, 2014 at 9:51 PM, Mark Brown <broonie@kernel.org> wrote:
>
>> > +       switch (params_width(params)) {
>> > +       case 16:
>
>> May be the better way will be to use define here and not hard coded value?
>
> No, it really is actually a number of bits.
Thanks, I didn't know about it.
In such case it is really unimportant to introduce define here.



-- 
Leon Romanovsky | Independent Linux Consultant
        www.leon.nu | leon@leon.nu
