From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: trouble using S/PDIF input on CMI8738-MC6:
	C-Media	CMI8738 (model 55)
Date: Wed, 13 Aug 2014 17:14:11 +0200
Message-ID: <53EB80C3.7020909@ladisch.de>
References: <53EA40EB.2060201@seniorblanco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 5F288260864
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 17:14:12 +0200 (CEST)
In-Reply-To: <53EA40EB.2060201@seniorblanco.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jon <jon@seniorblanco.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

jon wrote:
> Simple mixer control 'IEC958 In Record',0
>   Mono: Playback [off]

Shouldn't this be on?

> Simple mixer control 'IEC958 In Select',0
>   Mono: Playback [on]

IIRC this selects between two different inputs.
Try both settings.


Regards,
Clemens
