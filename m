From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2] ALSA: ASoC: McASP: add support for 24
 bit samples
Date: Tue, 09 Oct 2012 13:00:43 +0200
Message-ID: <507403DB.5050003@gmail.com>
References: <A551BDF323A45B48ACE6A404AA16A1C412786E53@TOP-EX01.TOPIC.LOCAL>
 <5073F2CD.9010407@gmail.com>
 <20121009102331.GB15207@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 81BB0264EF5
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 12:56:45 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so2099772bku.38
 for <alsa-devel@alsa-project.org>; Tue, 09 Oct 2012 04:00:52 -0700 (PDT)
In-Reply-To: <20121009102331.GB15207@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 09.10.2012 12:24, Mark Brown wrote:
> On Tue, Oct 09, 2012 at 11:47:57AM +0200, Daniel Mack wrote:
>> On 09.10.2012 11:41, Mike Looijmans wrote:
>>> Sorry for the lack of quoting, but I onle get the digest.
> 
>>> These are wrong:
> 
>>> +       case SNDRV_PCM_FORMAT_U24_LE: +       case
>>> SNDRV_PCM_FORMAT_S24_LE:
> 
>>> These pack a 24-bit sample value in a 32-bit word. The codec will
>>> send 32 bits to the McASP, and you should transfer 32 bits to the
>>> user, not just 24. Hence, SNDRV_PCM_FORMAT_S24_LE must be treated
>>> just like SNDRV_PCM_FORMAT_S32_LE.
> 
>>> I've tested that on a DA850-alike board with several TLV320AIC3256
>>> codecs, treating them as 3-byte samples will reasult in invalid
>>> data.
> 
>> Ok, thanks for reporting this. Would like to send a patch or want me to
>> fix it?
> 
> The above explanation isn't quite right.  For 24 bit the CODEC should be
> working with 24 bits on the wire (though obviously extra BCLKs are
> allowed) and the AP should be working with 32 bit words in memory.  The
> issue here is probably that you're working with real 24 bit data in RAM
> too.

Hmm, I don't understand. I thought S24_3LE exists to denote a 3-byte
representation, because S24_LE uses 32 bits? Hence Mike would be right
that S24_LE has to use a 4-byte dma transfer size, no?

I'm using S24_3LE here, hence that didn't hit me.

Where's the confusion? :)

Daniel
