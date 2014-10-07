From: Tobias Hoffmann <smilingthax@googlemail.com>
Subject: Re: [WIP PATCH] Scarlett mixer interface for 6i6, 18i6,
 18i8 and 18i20.
Date: Tue, 07 Oct 2014 17:24:54 +0200
Message-ID: <543405C6.5080607@googlemail.com>
References: <1412694986-2537-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f50.google.com (mail-la0-f50.google.com
 [209.85.215.50])
 by alsa0.perex.cz (Postfix) with ESMTP id C1E38260490
 for <alsa-devel@alsa-project.org>; Tue,  7 Oct 2014 17:25:02 +0200 (CEST)
Received: by mail-la0-f50.google.com with SMTP id s18so6565286lam.37
 for <alsa-devel@alsa-project.org>; Tue, 07 Oct 2014 08:25:02 -0700 (PDT)
In-Reply-To: <1412694986-2537-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, robin@gareus.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org

On 07/10/14 17:16, David Henningsson wrote:
> +#define CTLS_OUTPUT(index, name) \
> +	do { \
> +		err = add_output_ctls(mixer, index, name, info); \
> +		if (err<  0) \
> +			return err; \
> +	while (0)

AFAICS the last line should be:

      } while (0)


   Tobias
