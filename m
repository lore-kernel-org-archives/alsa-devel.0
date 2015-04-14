From: Nilhcraiv <nilhcraiv@gmail.com>
Subject: Re: Playback - Overwrite buffer with silence
Date: Tue, 14 Apr 2015 19:29:31 +0200
Message-ID: <14cb8fa84c0.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>
References: <5529421B.7050601@gmail.com> <55297E6E.20302@ladisch.de>
 <14caac41f10.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>
 <552A0974.1000005@ladisch.de>
 <14cb33de7e8.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>
 <552D0A01.6050308@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f44.google.com (mail-wg0-f44.google.com [74.125.82.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 719D92619E3
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 19:29:36 +0200 (CEST)
Received: by wgso17 with SMTP id o17so20125719wgs.1
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 10:29:36 -0700 (PDT)
In-Reply-To: <552D0A01.6050308@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens wrote:
    But an earlier function probably did.

It is the first call to " snd_pcm_sw_params_get_boundary" function and it 
return zero. If I use the function after "writei" then, the boundary value 
is a large number. What boundary means when the value is a large number?

Regards,
