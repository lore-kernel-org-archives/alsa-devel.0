From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [PATCH 0/5] for-linux/sndif: add explicit back and
 front synchronization
Date: Thu, 12 Apr 2018 19:11:15 +0300
Message-ID: <d5ede3f5-200e-f1c7-71f4-4ebfb938ca48@gmail.com>
References: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f49.google.com (mail-lf0-f49.google.com
 [209.85.215.49])
 by alsa0.perex.cz (Postfix) with ESMTP id EAA08266F69
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 18:11:22 +0200 (CEST)
Received: by mail-lf0-f49.google.com with SMTP id d20-v6so8513828lfe.3
 for <alsa-devel@alsa-project.org>; Thu, 12 Apr 2018 09:11:22 -0700 (PDT)
In-Reply-To: <20180412160102.15833-1-oleksandr_andrushchenko@epam.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: konrad.wilk@oracle.com, tiwai@suse.de
Cc: jgross@suse.com, alsa-devel@alsa-project.org, "Oleksandr_Andrushchenko@epam.com" <Oleksandr_Andrushchenko@epam.com>, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
List-Id: alsa-devel@alsa-project.org

Hello, Konrad, Takashi!

Could you please review the *Linux Kernel* version of the changes?
As I said in the cover letter below there is no functional changes
comparing to the corresponding Xen version, but spaces to tabs.
Still, formally, I have to drop the R-b tags and request for the new review.

Thank you,
Oleksandr

P.S. Minus GlobalLogic e-mails which bounce

On 04/12/2018 07:00 PM, Oleksandr Andrushchenko wrote:
> Hello, all!
>
> This is the syncup version of the sound protocol changes for
> Linux Kernel with the only difference from the corresponding Xen
> version being spaces to tabs conversion. Regradless of this only
> change I have dropped R-b tags received for Xen version.
>
> In order to provide explicit synchronization between backend and
> frontend the following changes are introduced in the protocol:
>   - bump protocol version to 2
>   - add new ring buffer for sending asynchronous events from
>     backend to frontend to report number of bytes played by the
>     frontend (XENSND_EVT_CUR_POS)
>   - introduce trigger events for playback control: start/stop/pause/resume
>   - add "req-" prefix to event-channel and ring-ref to unify naming
>     of the Xen event channels for requests and events
>   - add XENSND_OP_HW_PARAM_QUERY request to read/update
>     stream configuration space: request passes desired intervals/formats for
>     the stream parameters and the response returns allowed intervals and
>     formats mask that can be used.
>   - MAJOR: changed req/resp/evt packet sizes from 32 to 64 octets
>   -  Reworked XENSND_OP_HW_PARAM_QUERY so it now sends all
>     parameters at once, allowing to check all the configuration
>     space.
>   - Minor documentation cleanup (added missed "reserved" fields)
>
> Oleksandr Andrushchenko (5):
>    xen/sndif: Introduce protocol version
>    xen/sndif: Fix missed "reserved" fields in comments
>    xen/sndif: Make requests and responses 64 octets long
>    xen/sndif: Add explicit back and front synchronization
>    xen/sndif: Add explicit back and front parameter negotiation
>
>   include/xen/interface/io/sndif.h | 322 +++++++++++++++++++++++++++++--
>   1 file changed, 306 insertions(+), 16 deletions(-)
>
