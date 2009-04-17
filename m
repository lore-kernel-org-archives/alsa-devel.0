From: maarten van es <maarten.h.van.es@gmail.com>
Subject: bug in salsa async handler + patch
Date: Fri, 17 Apr 2009 20:30:45 +0100
Message-ID: <bca65b460904171230v110cfb10vda83808fff4521f1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.158])
	by alsa0.perex.cz (Postfix) with ESMTP id 029801037FB
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Apr 2009 21:30:45 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 22so405714fge.21
	for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2009 12:30:45 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I couldn't find where or how to submit patches for salsa, so here
goes. This patch resolves random program crashes when using libsalsa
with an async handler: snd_async_del_handler does not correctly
maintain its list of async handlers. This patch is for
salsa-lib-0.0.21, the latest stable version.

change src/async.c, line 118
async_list = h;

to src/async.c, line 118
async_list = h->next;

Maarten
