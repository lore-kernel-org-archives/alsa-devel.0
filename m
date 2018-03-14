From: Oleksandr Andrushchenko <andr2000@gmail.com>
Subject: [Xen-devel][PATCH v2 0/3] sndif: add explicit back and
	front synchronization
Date: Wed, 14 Mar 2018 18:02:42 +0200
Message-ID: <1521043365-26813-1-git-send-email-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C75826708E
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 17:02:54 +0100 (CET)
Received: by mail-lf0-f66.google.com with SMTP id a22-v6so5598922lfg.9
 for <alsa-devel@alsa-project.org>; Wed, 14 Mar 2018 09:02:54 -0700 (PDT)
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

Thank you,
Oleksandr Andrushchenko

Oleksandr Andrushchenko (3):
  sndif: Introduce protocol version
  sndif: Add explicit back and front synchronization
  sndif: Add explicit back and front parameter negotiation

 xen/include/public/io/sndif.h | 295 ++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 286 insertions(+), 9 deletions(-)

-- 
2.7.4
