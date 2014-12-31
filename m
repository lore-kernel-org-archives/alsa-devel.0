From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: Re: [PATCH v2] sound: pci: asihpi: hpifunc.c: Remove
	some unused functions
Date: Wed, 31 Dec 2014 17:41:33 +0100
Message-ID: <CAKXHbyOEp=juzjaqsNt9RXn02VYDJXvESK4o_vAhMtFGmK=dHA@mail.gmail.com>
References: <1420039022-10018-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
 <s5h7fx7hkga.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f182.google.com (mail-ie0-f182.google.com
 [209.85.223.182])
 by alsa0.perex.cz (Postfix) with ESMTP id A226A260430
 for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2014 17:41:35 +0100 (CET)
Received: by mail-ie0-f182.google.com with SMTP id x19so14997339ier.27
 for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2014 08:41:34 -0800 (PST)
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com.
 [209.85.223.174])
 by mx.google.com with ESMTPSA id b7sm17171537igx.15.2014.12.31.08.41.33
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Wed, 31 Dec 2014 08:41:33 -0800 (PST)
Received: by mail-ie0-f174.google.com with SMTP id at20so15130413iec.19
 for <alsa-devel@alsa-project.org>; Wed, 31 Dec 2014 08:41:33 -0800 (PST)
In-Reply-To: <s5h7fx7hkga.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

2014-12-31 17:07 GMT+01:00 Takashi Iwai <tiwai@suse.de>:

> At Wed, 31 Dec 2014 16:17:02 +0100,
> Rickard Strandqvist wrote:
> >
> > Removes some functions that are not used anywhere:
>
> See Eliot's previous reply.  There will be some code changes, so this
> action is no-go as of now.
>
>
> thanks,
>
> Takashi
>


Hi Takashi

I have restored the function hpi_adapter_set_property() that Eliot wanted.
And I also have diff the files against the linux-next, but that there are
some notable differences.

What is it you do not like about my current patch?


Kind regards
Rickard Strandqvist
