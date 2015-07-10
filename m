From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Possible Bug Found with Xonar Stx Driver
Date: Fri, 10 Jul 2015 14:13:38 +0200
Message-ID: <559FB6F2.2000606@ladisch.de>
References: <559EFC14.2090408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id EA9F4260499
 for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2015 14:13:41 +0200 (CEST)
In-Reply-To: <559EFC14.2090408@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: nick <xerofoify@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

nick wrote:
> After running the latest version of Linus's tree I am noticed way more buffering

What exactly do you mean with the word "buffering"?

> when playing music with my Xonar STX card when building kernels then
> under the Ubuntu kernel version of 3.19.16.

Sounds like a change in the disk access patterns.

The audio buffer size is chosen by the playing application (whatever it
is).

> I have tried bisecting it between the releases of 3.18 and 4.0
> and was unable to narrow it down to a buggy commit.

There was no relevant change in the sound driver.


Regards,
Clemens
