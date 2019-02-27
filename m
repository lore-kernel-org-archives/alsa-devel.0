From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: increase number of alsa loopback
Date: Wed, 27 Feb 2019 15:35:51 +0100
Message-ID: <04bde94b-1071-edc0-fd7a-cb0080ef79fa@perex.cz>
References: <dd6a3a76-a394-3da8-286d-c316fee6c487@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9C885F89699
 for <alsa-devel@alsa-project.org>; Wed, 27 Feb 2019 15:35:54 +0100 (CET)
In-Reply-To: <dd6a3a76-a394-3da8-286d-c316fee6c487@gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Olivier SCHMITT <sc.olivier@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 27. 02. 19 v 15:20 Olivier SCHMITT napsal(a):
> Hello All,
> 
> First, thanks for your project!
> 
> I search to increase the maximum number of 32 alsa loopback.
> 
> Can someone say me how do this?

There's hardcoded limit for the PCM substreams to 8, but you may enable
more loopback cards (options snd-aloop enable=1,1,1,1).

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
