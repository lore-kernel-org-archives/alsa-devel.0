From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: parallel, real time safe waiting?
Date: Wed, 15 Apr 2015 09:52:17 +0200
Message-ID: <552E18B1.60102@ladisch.de>
References: <trinity-f5deb6ac-8715-451e-b150-bfd93a6537ea-1429041816217@3capp-gmx-bs67>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 06F9F2605D2
 for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2015 09:52:17 +0200 (CEST)
In-Reply-To: <trinity-f5deb6ac-8715-451e-b150-bfd93a6537ea-1429041816217@3capp-gmx-bs67>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Johannes Lorenz <johannes89@mailueberfall.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Johannes Lorenz wrote:
> You said snd_pcm_wait() was real time safe. I guess that's also true
> for similar functions, like snd_pcm_htimestamp(), snd_pcm_readi(), ...,
> correct?

Yes for all devices I know, but plugins might implement this differently.
(But there's nothing you could do about it, so don't bother worrying.)


Regards,
Clemens
