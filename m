From: happy musicmaker <happy.musicmaker@gmail.com>
Subject: ALSA MIDI exclusive mode ?
Date: Mon, 4 Sep 2017 18:34:54 +0800
Message-ID: <CAJDJRCqNBANLhyc0RpUrz+3G_fzmGO0nGddi2j_WVx8NAo+qdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f181.google.com (mail-yw0-f181.google.com
 [209.85.161.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 221AC266F04
 for <alsa-devel@alsa-project.org>; Mon,  4 Sep 2017 12:34:55 +0200 (CEST)
Received: by mail-yw0-f181.google.com with SMTP id i66so478362ywc.0
 for <alsa-devel@alsa-project.org>; Mon, 04 Sep 2017 03:34:55 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I ready somewhere that some applications, like Bitwig, allocate(?) MIDI
ports in "exclusive" mode so that other application cannot connect to the
MIDI ports. I used Bitwig and confirmed  that after starting Bitwig in
qjackctrl you cannot connect any of the MIDI write/read ports. ( qjackctrl
MIDI option  is set to "none") I could not find any documentation on such
"exclusive" feature though ?
