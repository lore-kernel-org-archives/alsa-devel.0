From: nerwusek <luk0104@gmail.com>
Subject: Re: uda1380 and pxa255 plays nothing but noise
Date: Tue, 07 Aug 2012 21:39:28 +0200
Message-ID: <50216EF0.5070108@gmail.com>
References: <50216A11.3050407@gmail.com> <20120807192645.GD14711@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 83BAB265FE9
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 21:10:08 +0200 (CEST)
Received: by bkcjk13 with SMTP id jk13so1453709bkc.38
 for <alsa-devel@alsa-project.org>; Tue, 07 Aug 2012 12:39:54 -0700 (PDT)
In-Reply-To: <20120807192645.GD14711@sirena.org.uk>
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

On 07.08.2012 21:26, Mark Brown wrote:
> On Tue, Aug 07, 2012 at 09:18:41PM +0200, nerwusek wrote:
>
>> I'm trying to enable sound on my iPAQ h2200 device using ALSA ASoC.
>> I've created driver basing on hx4700.c and magician.c files, but I
>> can't hear is anything. When I am playing music on device file
>> uda1380-codec.0-0018/dapm/Playback shows that stream Playback is
>> active, but in DAC that stream is inactive (but DAC is on). I also
>> noticed that on I2S bus is nothing going on. I've lost many hours on
>> looking for problem. Is there anyone who could help me?
> Have you checked that the output isn't muted, has the audio routed to
> the output you're using and has a suitable volume?
