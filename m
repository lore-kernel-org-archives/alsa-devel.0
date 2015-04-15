From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Playback - Overwrite buffer with silence
Date: Wed, 15 Apr 2015 11:14:51 +0800
Message-ID: <CAN8ccibpiKiLXDvjTGGUe8ZkdOvp=9N6QoOrJPLnPmkNWZjOhg@mail.gmail.com>
References: <5529421B.7050601@gmail.com> <55297E6E.20302@ladisch.de>
 <14caac41f10.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>
 <552A0974.1000005@ladisch.de>
 <14cb33de7e8.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>
 <552D0A01.6050308@ladisch.de>
 <14cb8fa84c0.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vn0-f43.google.com (mail-vn0-f43.google.com
 [209.85.216.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 40BE426545B
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2015 05:14:53 +0200 (CEST)
Received: by vnbf62 with SMTP id f62so10915900vnb.3
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 20:14:52 -0700 (PDT)
In-Reply-To: <14cb8fa84c0.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

>
> Clemens wrote:
>    But an earlier function probably did.
>
> It is the first call to " snd_pcm_sw_params_get_boundary" function and it
return zero. If I use the function after "writei" then, the boundary value
is a large number. What boundary means when the value is a large number?
>

You have to add snd_pcm_dump() after snd_pcm_hw_params() to dump those
paramters accepted by your default device

Not all default device support two periods per buffer as you did not
explicitly set periods or period_size

Most functions which you used can return error
