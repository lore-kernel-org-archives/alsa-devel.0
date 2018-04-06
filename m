From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: Re: [Xen-devel] [PATCH v3 0/5] sndif: add explicit
 back and front synchronization
Date: Fri, 6 Apr 2018 12:18:39 +0300
Message-ID: <835ef633-575c-63ec-e3b5-80d0f1dd4cf9@gmail.com>
References: <1521444144-12451-1-git-send-email-andr2000@gmail.com>
 <22b14d78-701d-f5c6-0b0b-b95b28bfe19c@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f41.google.com (mail-wm0-f41.google.com [74.125.82.41])
 by alsa0.perex.cz (Postfix) with ESMTP id C492E267235
 for <alsa-devel@alsa-project.org>; Fri,  6 Apr 2018 11:18:41 +0200 (CEST)
Received: by mail-wm0-f41.google.com with SMTP id x82so1881619wmg.1
 for <alsa-devel@alsa-project.org>; Fri, 06 Apr 2018 02:18:41 -0700 (PDT)
In-Reply-To: <22b14d78-701d-f5c6-0b0b-b95b28bfe19c@suse.com>
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
To: Juergen Gross <jgross@suse.com>, alsa-devel@alsa-project.org, xen-devel@lists.xenproject.org, konrad.wilk@oracle.com, tiwai@suse.de
Cc: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

On 04/06/2018 12:13 PM, Juergen Gross wrote:
> On 19/03/18 08:22, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> Hello, all!
>>
>> In order to provide explicit synchronization between backend and
>> frontend the following changes are introduced in the protocol:
>>   - bump protocol version to 2
>>   - add new ring buffer for sending asynchronous events from
>>     backend to frontend to report number of bytes played by the
>>     frontend (XENSND_EVT_CUR_POS)
>>   - introduce trigger events for playback control: start/stop/pause/resume
>>   - add "req-" prefix to event-channel and ring-ref to unify naming
>>     of the Xen event channels for requests and events
>>   - add XENSND_OP_HW_PARAM_QUERY request to read/update
>>     stream configuration space: request passes desired intervals/formats for
>>     the stream parameters and the response returns allowed intervals and
>>     formats mask that can be used.
>>
>> Changes since v2:
>> 1. Konrad's r-b tag for version patch
>> 2. MAJOR: changed req/resp/evt packet sizes from 32 to 64 octets
>> 3. Reworked XENSND_OP_HW_PARAM_QUERY so it now sends all
>>     parameters at once, allowing to check all the configuration
>>     space.
>> 4. Minor documentation cleanup (added missed "reserved" fields)
>>
>> Changes since v1:
>>
>> 1. Changed protocol version definition from string to integer,
>> so it can easily be used in comparisons.
>> Konrad, I have removed your r-b tag for the reason of this change.
>>
>> 2. In order to provide explicit stream parameter negotiation between
>> backend and frontend the following changes are introduced in the protocol:
>> add XENSND_OP_HW_PARAM_QUERY request to read/update
>> configuration space for the parameter given: request passes
>> desired parameter interval (mask) and the response to this request
>> returns min/max interval (mask) for the parameter to be used.
>>
>> Parameters supported by this request/response:
>>   - format mask
>>   - sample rate interval
>>   - number of channels interval
>>   - buffer size, interval, frames
>>   - period size, interval, frames
>>
>> Oleksandr Andrushchenko (5):
>>    sndif: Introduce protocol version
>>    sndif: Fix missed "reserved" fields in comments
>>    sndif: Make requests and responses 64 octets long
>>    sndif: Add explicit back and front synchronization
>>    sndif: Add explicit back and front parameter negotiation
>>
>>   xen/include/public/io/sndif.h | 322 +++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 306 insertions(+), 16 deletions(-)
>>
> With Konrad's ack you can have my:
>
> Release-acked-by: Juergen Gross <jgross@suse.com>
Thank you
>
> even if the commit can't be done before the freeze. The header isn't
> used inside Xen so the risk for the release is zero.
This is true
>
> Juergen
Thank you,
Oleksandr
