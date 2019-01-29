From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 1/1] seq: arecordmidi: Add num-events option
Date: Tue, 29 Jan 2019 17:45:02 +0900
Message-ID: <20190129084502.GA9419@workstation>
References: <5c4fb010.1c69fb81.94ca0.01ae@mx.google.com>
 <f0c4b673-52a2-fc1d-c9d8-4e4b42f999f1@sakamocchi.jp>
 <CACeCKacREMJDGWNJrdydu3+P1EZ81AyaY0sPfBhuiT11nnvV5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com
 [209.85.210.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 2A92E26749A
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 09:45:10 +0100 (CET)
Received: by mail-pf1-f194.google.com with SMTP id 64so9340743pfr.9
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 00:45:10 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CACeCKacREMJDGWNJrdydu3+P1EZ81AyaY0sPfBhuiT11nnvV5A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Prashant Malani <pmalani@chromium.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, Jan 28, 2019 at 09:34:59PM -0800, Prashant Malani wrote:
> Can I duplicate this in arecordmidi.c ? I'm loath to introduce a
> header, and then refactor axfer/main.c.

I don't mind it.

When parsing string with non-numeric characters, the behaviour of
atoi() is undefined still in C11.

$ cd alsa-utils.git
$ git grep atoi | grep optarg | wc
     39     158    1919

Mmm... Many parts are written without enough care of the undefined
behaviour...


Thanks

Takashi Sakamoto
