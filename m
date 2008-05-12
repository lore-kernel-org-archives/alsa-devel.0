From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Forward/rewind APIs return 0
Date: Mon, 12 May 2008 10:17:17 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0805121016590.18373@tm8103.perex-int.cz>
References: <5A47E75E594F054BAF48C5E4FC4B92AB02224F6413@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 28F8F248F3
	for <alsa-devel@alsa-project.org>;
	Mon, 12 May 2008 10:17:18 +0200 (CEST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB02224F6413@dbde02.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 12 May 2008, Aggarwal, Anuj wrote:

> Hi,
> 
> I am trying to use snd_pcm_forward and snd_pcm_rewind APIs in my 
> application. Although they are doing something (I am able to 'hear' the 
> jump), they return me 0, instead of returning me the number of frames.
> 
> What could be the problem with the application/driver?

Show us output from snd_pcm_dump().

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
