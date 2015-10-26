From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Using snd_pcm_set_params() on a capture handle
Date: Mon, 26 Oct 2015 10:17:16 +0100
Message-ID: <562DEF9C.8090706@ladisch.de>
References: <20151025174442.b318e489f0568566a4b82908@mega-nerd.com>
 <562D376E.7000308@ladisch.de>
 <20151026194701.7258eceaea5cb7a7a41bcf94@mega-nerd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id B9DD5260522
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 10:17:18 +0100 (CET)
Received: from [10.1.2.65] (unknown [94.101.37.4])
 by dehamd003.servertools24.de (Postfix) with ESMTPSA id D4358F520013
 for <alsa-devel@alsa-project.org>; Mon, 26 Oct 2015 10:17:17 +0100 (CET)
In-Reply-To: <20151026194701.7258eceaea5cb7a7a41bcf94@mega-nerd.com>
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

Erik de Castro Lopo wrote:
>     RATE: [44100 96000]

snd_pcm_set_params() should have chosen a single rate.
Did you dump this after that call?


Regards,
Clemens
