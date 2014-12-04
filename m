From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: DMA buffer alignment
Date: Thu, 04 Dec 2014 17:20:51 +0100
Message-ID: <548089E3.4060105@ladisch.de>
References: <CAOQ7t2b5Rr6OjpQQ8uvwQ+7O2RL=tTKyjWG1HSJuOc3X4-NDag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id EEB30262634
 for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2014 17:21:18 +0100 (CET)
In-Reply-To: <CAOQ7t2b5Rr6OjpQQ8uvwQ+7O2RL=tTKyjWG1HSJuOc3X4-NDag@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carlo Caione <carlo@caione.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Carlo Caione wrote:
> Several user-space programs (like aplay) work well with my hw, since
> the buffer sent from the user-space is always (padded) of period-size
> bytes, that is aligned to my 64 bytes boundary. Others (like
> speaker-test) are not working because sometimes they snd_pcm_writei()
> a buffer that is not multiple of 64 bytes.

When a program writes two chunks of 32 bytes each, the final contents of
the memory are the same.  So what exactly is the problem?


Regards,
Clemens
