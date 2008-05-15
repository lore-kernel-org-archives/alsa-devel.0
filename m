From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Forward/rewind APIs return 0
Date: Thu, 15 May 2008 13:30:00 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0805151326470.18373@tm8103.perex-int.cz>
References: <5A47E75E594F054BAF48C5E4FC4B92AB022256EF6F@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 670F824788
	for <alsa-devel@alsa-project.org>;
	Thu, 15 May 2008 13:30:01 +0200 (CEST)
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB022256EF6F@dbde02.ent.ti.com>
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

On Thu, 15 May 2008, Aggarwal, Anuj wrote:

> Please find the output from snd_pcm_dump() attached.

Ok, replace snd_pcm_dump() with snd_pcm_status_dump() and send output 
again, please. Also, if you can send me (privately) your test code, I'll 
try to check it and reproduce the problem.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
