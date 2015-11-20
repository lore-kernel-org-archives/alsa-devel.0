From: Caleb Crome <caleb@crome.org>
Subject: Re: Simple-card without codec for testing purpose
Date: Thu, 19 Nov 2015 17:24:36 -0800
Message-ID: <CAG5mAdw7_bLC9cFzAyUiPwC+UgQ6pgGHQA7D8z9PPDomUSR6FA@mail.gmail.com>
References: <564E0656.9000709@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f171.google.com (mail-io0-f171.google.com
 [209.85.223.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E9E82614F4
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2015 02:24:57 +0100 (CET)
Received: by iofh3 with SMTP id h3so109115890iof.3
 for <alsa-devel@alsa-project.org>; Thu, 19 Nov 2015 17:24:56 -0800 (PST)
In-Reply-To: <564E0656.9000709@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I've been wondering about that too. I don't know how to do it easily.

-Caleb


On Thu, Nov 19, 2015 at 9:26 AM, arnaud.mouiche@invoxia.com
<arnaud.mouiche@invoxia.com> wrote:
> Hello,
>
> I'm starting debugging / testing all the fsl_ssi issues (see Caleb's
> previous post).
>
> First step I just need to setup a DTS entry for  "simple-card" + fake codec
> to generate arbitrary PCM bus output (1 to 16 channels, various TDM, various
> sampling rate and format and master/slave role)
> I will then plug my logical analyser, or do some loopback, or plug a FPGA to
> generate/check some patterns.
>
> Is there such "fake codec" somewhere.  Indeed, something that look like the
> bt-sco codec, but without rate/format/channel limitations ?
> Or does the "simple-card" even needs one ?
>
> Regards,
> Arnaud
