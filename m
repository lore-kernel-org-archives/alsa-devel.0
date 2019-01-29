From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/1] seq: arecordmidi: Add num-events option
Date: Tue, 29 Jan 2019 17:18:05 +0100
Message-ID: <ef5b180f-e1da-7ec9-9e2b-0b5b4b86ac14@ladisch.de>
References: <5c4fb010.1c69fb81.94ca0.01ae@mx.google.com>
 <f0c4b673-52a2-fc1d-c9d8-4e4b42f999f1@sakamocchi.jp>
 <CACeCKacREMJDGWNJrdydu3+P1EZ81AyaY0sPfBhuiT11nnvV5A@mail.gmail.com>
 <20190129084502.GA9419@workstation>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 90C80267454
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 17:19:00 +0100 (CET)
In-Reply-To: <20190129084502.GA9419@workstation>
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
To: alsa-devel@alsa-project.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Prashant Malani <pmalani@chromium.org>
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> When parsing string with non-numeric characters, the behaviour of
> atoi() is undefined still in C11.

A completely non-numeric string is specified to return zero.

The behaviour is undefined only if the value cannot be represented, i.e.,
if it overflows.


Regards,
Clemens
