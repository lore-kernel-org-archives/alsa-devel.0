From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Playback - Overwrite buffer with silence
Date: Thu, 16 Apr 2015 22:16:06 +0200
Message-ID: <55301886.2070906@ladisch.de>
References: <5529421B.7050601@gmail.com>	<55297E6E.20302@ladisch.de>	<14caac41f10.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>	<552A0974.1000005@ladisch.de>	<14cb33de7e8.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>	<552D0A01.6050308@ladisch.de>	<14cb8fa84c0.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>	<CAN8ccibpiKiLXDvjTGGUe8ZkdOvp=9N6QoOrJPLnPmkNWZjOhg@mail.gmail.com>	<552EBB90.8040707@gmail.com>	<552EBEBA.9000108@ladisch.de>
 <55300038.6010507@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 32FC8261A57
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2015 22:16:31 +0200 (CEST)
In-Reply-To: <55300038.6010507@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nilhcraiv <nilhcraiv@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Nilhcraiv wrote:
> Why the buffer is not overwrite with silence with this pcm setup?
>
> ALSA <-> PulseAudio PCM I/O Plugin
> Its setup is:
>   silence_threshold: 0
>   silence_size : 6485183463413514240
>   boundary     : 6485183463413514240

I guess PulseAudio does not handle the silencing correctly.


Regards,
Clemens
