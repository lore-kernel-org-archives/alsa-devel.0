From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2] ALSA: ASoC: McASP: add support for 24
 bit samples
Date: Tue, 09 Oct 2012 11:47:57 +0200
Message-ID: <5073F2CD.9010407@gmail.com>
References: <A551BDF323A45B48ACE6A404AA16A1C412786E53@TOP-EX01.TOPIC.LOCAL>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 087C6264EEB
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 11:48:04 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so2060100bku.38
 for <alsa-devel@alsa-project.org>; Tue, 09 Oct 2012 02:48:04 -0700 (PDT)
In-Reply-To: <A551BDF323A45B48ACE6A404AA16A1C412786E53@TOP-EX01.TOPIC.LOCAL>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 09.10.2012 11:41, Mike Looijmans wrote:
> Sorry for the lack of quoting, but I onle get the digest.
> 
> These are wrong:
> 
> +       case SNDRV_PCM_FORMAT_U24_LE: +       case
> SNDRV_PCM_FORMAT_S24_LE:
> 
> These pack a 24-bit sample value in a 32-bit word. The codec will
> send 32 bits to the McASP, and you should transfer 32 bits to the
> user, not just 24. Hence, SNDRV_PCM_FORMAT_S24_LE must be treated
> just like SNDRV_PCM_FORMAT_S32_LE.
> 
> I've tested that on a DA850-alike board with several TLV320AIC3256
> codecs, treating them as 3-byte samples will reasult in invalid
> data.

Ok, thanks for reporting this. Would like to send a patch or want me to
fix it?


Daniel
