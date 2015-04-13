From: Nilhcraiv <nilhcraiv@gmail.com>
Subject: Re: Playback - Overwrite buffer with silence
Date: Mon, 13 Apr 2015 16:45:23 +0200
Message-ID: <14cb33de7e8.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>
References: <5529421B.7050601@gmail.com> <55297E6E.20302@ladisch.de>
 <14caac41f10.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>
 <552A0974.1000005@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id D49972650FE
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 16:45:27 +0200 (CEST)
Received: by widdi4 with SMTP id di4so54785587wid.0
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 07:45:26 -0700 (PDT)
In-Reply-To: <14cb331e1c8.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>
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
    It is impossible for the boundar to be zero.

In my code snd_pcm_sw_params_get_boundary(swparams, &boundary) function 
does not return a negative value and the boundary variable is set to zero 
then, the boundar is zero.

In any case, How I can put silence in buffer to avoid underrun? Do you know 
the answer?

Thank you in advance.
