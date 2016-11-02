From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: CREATIVE EMU 0202 driver in 192khz
Date: Wed, 2 Nov 2016 12:35:00 +0100
Message-ID: <c550014d-d1cb-cef0-499b-db9f209dbdf0@ladisch.de>
References: <CALzsnJSbzNHvNZp8O=arZq29Qo224=E8mjZRQwpAithbokEnXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id EBB79266B4B
 for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2016 12:35:04 +0100 (CET)
In-Reply-To: <CALzsnJSbzNHvNZp8O=arZq29Qo224=E8mjZRQwpAithbokEnXg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Olivier Schmitt <sc.olivier@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Olivier Schmitt wrote:
> When the clock Rate is to 5, we see on our watterfall that the sample rate
> will change on the hardware but alsa dont let somme software to use 192khz.

How exactly did you observe this?

Does "aplay -D hw:USB -t raw -c 2 -f S16_LE -r 192000 -d 1 /dev/zero" work?


Regards,
Clemens
