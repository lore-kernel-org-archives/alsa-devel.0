From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Playback - Overwrite buffer with silence
Date: Tue, 14 Apr 2015 14:37:21 +0200
Message-ID: <552D0A01.6050308@ladisch.de>
References: <5529421B.7050601@gmail.com>
 <55297E6E.20302@ladisch.de>	<14caac41f10.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>	<552A0974.1000005@ladisch.de>
 <14cb33de7e8.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 1DAF226054A
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 14:37:21 +0200 (CEST)
In-Reply-To: <14cb33de7e8.2759.f6cded7c48a54b1428bcde82a72ee7d7@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nilhcraiv <nilhcraiv@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Nilhcraiv wrote:
> Clemens wrote:
> > It is impossible for the boundar to be zero.
>
> In my code snd_pcm_sw_params_get_boundary(swparams, &boundary)
> function does not return a negative value

But an earlier function probably did.


Regards,
Clemens
