From: James Cameron <quozl@laptop.org>
Subject: Re: snd_pcm_hw_params_set_buffer_size_near yields
 EINVAL for the value 1681
Date: Wed, 14 Oct 2015 10:03:11 +1100
Message-ID: <20151013230311.GG18868@us.netrek.org>
References: <CACXN+=QJL__aiKxsgNsygE08JYdRYyV-DwBisES+41td8Ak+Lw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from zimbra.real-time.com (zimbra.real-time.com [63.170.91.9])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CE7E264FE7
 for <alsa-devel@alsa-project.org>; Wed, 14 Oct 2015 01:03:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CACXN+=QJL__aiKxsgNsygE08JYdRYyV-DwBisES+41td8Ak+Lw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Kelley <superjoe30@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 13, 2015 at 06:15:04AM +0000, Andrew Kelley wrote:
> When I call snd_pcm_hw_params_set_buffer_size_near with the value 1681, I
> get an EINVAL error.
> 
> What in the world is going on here?

My guess is one of the lower levels hw_params ops is returning EINVAL,
so you'll have to identify which drivers you are using, then find out
why they are doing it.

-- 
James Cameron
http://quozl.linux.org.au/
