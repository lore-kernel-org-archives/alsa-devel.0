From: Sven Van Asbroeck <thesven73@gmail.com>
Subject: Re: [RFC PATCH 1/4] alsa: make hw_params negotiation
 infrastructure 'bclk_ratio aware'
Date: Fri, 8 Mar 2019 15:07:05 -0500
Message-ID: <CAGngYiVaFswVrVYfUpo4YfkH+nxwaW+8q8q3C6_wfggS7YCYjw@mail.gmail.com>
References: <20190304165955.21696-1-TheSven73@gmail.com>
 <20190305044232.GA15636@workstation>
 <CAGngYiWDO6YTTMGOFwpzQCOkxEr+AOz3ScDt748w_0UuUk+JLw@mail.gmail.com>
 <20190308041056.GA1172@workstation>
 <20190308125916.2cgiqclp6jmlfbim@shell.armlinux.org.uk>
 <20190308172235.GA31189@sirena.org.uk>
 <25dec9c5-af5c-bc54-89dd-2abdeffa9f82@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com
 [IPv6:2607:f8b0:4864:20::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5F728F806F7
 for <alsa-devel@alsa-project.org>; Fri,  8 Mar 2019 21:07:17 +0100 (CET)
Received: by mail-oi1-x242.google.com with SMTP id e7so16819504oia.8
 for <alsa-devel@alsa-project.org>; Fri, 08 Mar 2019 12:07:17 -0800 (PST)
In-Reply-To: <25dec9c5-af5c-bc54-89dd-2abdeffa9f82@perex.cz>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Russell King - ARM Linux admin <linux@armlinux.org.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Mar 8, 2019 at 2:54 PM Jaroslav Kysela <perex@perex.cz> wrote:
>
> I agree. We just need a library which will:
>
> 1) gather the information from hardware drivers
>   - a simple description of the bclk constrains
> 2) create right constraints (hw_params rules) for the ALSA PCM API
> 3) return the selected bclk when hw_params are installed
>

Yes, that's what the RFC patch I posted attempts to do.
But it extends hw_params, which is clearly wrong.

>
> The library should not extend hw_params (new interval), but it should
> work as a separate layer - use new structures / functions etc.
>

This, I could not work out how to approach :)
