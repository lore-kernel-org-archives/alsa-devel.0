From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Alsa-info.sh is never released
Date: Tue, 22 Jul 2014 08:28:10 +0200
Message-ID: <53CE047A.7000909@canonical.com>
References: <53CDFEB6.5070600@canonical.com> <s5hwqb5hq1j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id A0C562654D4
 for <alsa-devel@alsa-project.org>; Tue, 22 Jul 2014 08:28:11 +0200 (CEST)
In-Reply-To: <s5hwqb5hq1j.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, adconrad@0c3.net, luke.yelavich@canonical.com
List-Id: alsa-devel@alsa-project.org



On 2014-07-22 08:21, Takashi Iwai wrote:
> At Tue, 22 Jul 2014 08:03:34 +0200,
> David Henningsson wrote:
>>
>> Hi,
>>
>> Since ~two years back Ubuntu ships alsa-info.sh on new installations, in
>> order to have bug reports that are upstream compatible.
>>
>> However, alsa-info.sh seems to be a part of the alsa-driver git tree,
>> and the alsa-driver package is not released anymore, since we think that
>> is a part of the Linux kernel. As a result, alsa-info.sh is no longer
>> part of an upstream tarball that we can package in the usual way.
>>
>> So maybe we should move alsa-info somewhere else, e g alsa-utils? What
>> do you think?
>
> +1.  alsa-utils or alsa-tools is a better place to maintain.

I'd prefer alsa-utils over alsa-tools: alsa-utils seems to have generic 
utilities and alsa-tools specialised ones (i e for some specific 
hardware). Since alsa-info is a generic tool (usable for everyone, 
regardless of driver/hardware), alsa-utils seems to be a better fit.


-- 
David Henningsson, Canonical Ltd.
https://launchpad.net/~diwic
