From: happy musicmaker <happy.musicmaker@gmail.com>
Subject: Re: ALSA MIDI exclusive mode ?
Date: Wed, 6 Sep 2017 14:27:39 +0800
Message-ID: <CAJDJRCq3dP+ZMB4EW8iCyRwi_4nd39_Gv4Zc__JAzCrCAAgV8w@mail.gmail.com>
References: <CAJDJRCqNBANLhyc0RpUrz+3G_fzmGO0nGddi2j_WVx8NAo+qdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f182.google.com (mail-yw0-f182.google.com
 [209.85.161.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 16DCD26734C
 for <alsa-devel@alsa-project.org>; Wed,  6 Sep 2017 08:27:40 +0200 (CEST)
Received: by mail-yw0-f182.google.com with SMTP id r85so3920303ywg.1
 for <alsa-devel@alsa-project.org>; Tue, 05 Sep 2017 23:27:40 -0700 (PDT)
In-Reply-To: <CAJDJRCqNBANLhyc0RpUrz+3G_fzmGO0nGddi2j_WVx8NAo+qdQ@mail.gmail.com>
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

Figured it out. The so called "exclusive" mode is because of the
application opening the port in "raw mode"
So far I only used sequencer mode in my code and this did not bump into
this situation.


On Mon, Sep 4, 2017 at 6:34 PM, happy musicmaker <happy.musicmaker@gmail.com
> wrote:

>
> I ready somewhere that some applications, like Bitwig, allocate(?) MIDI
> ports in "exclusive" mode so that other application cannot connect to the
> MIDI ports. I used Bitwig and confirmed  that after starting Bitwig in
> qjackctrl you cannot connect any of the MIDI write/read ports. ( qjackctrl
> MIDI option  is set to "none") I could not find any documentation on such
> "exclusive" feature though ?
>
>
>
