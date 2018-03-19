From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [Xen-devel][PATCH v3 0/5] sndif: add explicit back and
	front synchronization
Date: Mon, 19 Mar 2018 09:22:19 +0200
Message-ID: <1521444144-12451-1-git-send-email-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f41.google.com (mail-lf0-f41.google.com
 [209.85.215.41])
 by alsa0.perex.cz (Postfix) with ESMTP id C965F267299
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 08:22:35 +0100 (CET)
Received: by mail-lf0-f41.google.com with SMTP id o102-v6so1255710lfg.8
 for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2018 00:22:35 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, xen-devel@lists.xenproject.org, konrad.wilk@oracle.com, tiwai@suse.de
Cc: andr2000@gmail.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: alsa-devel@alsa-project.org

From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>

Hello, all!

In order to provide explicit synchronization between backend and
frontend the following changes are introduced in the protocol:
 - bump protocol version to 2
 - add new ring buffer for sending asynchronous events from
   backend to frontend to report number of bytes played by the
   frontend (XENSND_EVT_CUR_POS)
 - introduce trigger events for playback control: start/stop/pause/resume
 - add "req-" prefix to event-channel and ring-ref to unify naming
   of the Xen event channels for requests and events
 - add XENSND_OP_HW_PARAM_QUERY request to read/update
   stream configuration space: request passes desired intervals/formats for
   the stream parameters and the response returns allowed intervals and
   formats mask that can be used.

Changes since v2:
1. Konrad's r-b tag for version patch
2. MAJOR: changed req/resp/evt packet sizes from 32 to 64 octets
3. Reworked XENSND_OP_HW_PARAM_QUERY so it now sends all 
   parameters at once, allowing to check all the configuration
   space.
4. Minor documentation cleanup (added missed "reserved" fields)

Changes since v1:

1. Changed protocol version definition from string to integer,
so it can easily be used in comparisons.
Konrad, I have removed your r-b tag for the reason of this change.

2. In order to provide explicit stream parameter negotiation between
backend and frontend the following changes are introduced in the protocol:
add XENSND_OP_HW_PARAM_QUERY request to read/update
configuration space for the parameter given: request passes
desired parameter interval (mask) and the response to this request
returns min/max interval (mask) for the parameter to be used.

Parameters supported by this request/response:
 - format mask
 - sample rate interval
 - number of channels interval
 - buffer size, interval, frames
 - period size, interval, frames

Oleksandr Andrushchenko (5):
  sndif: Introduce protocol version
  sndif: Fix missed "reserved" fields in comments
  sndif: Make requests and responses 64 octets long
  sndif: Add explicit back and front synchronization
  sndif: Add explicit back and front parameter negotiation

 xen/include/public/io/sndif.h | 322 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 306 insertions(+), 16 deletions(-)

-- 
2.7.4
