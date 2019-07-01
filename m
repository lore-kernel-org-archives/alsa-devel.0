From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: ALSA repos
Date: Mon, 1 Jul 2019 16:20:59 +0200
Message-ID: <6fe0a77d-d9c3-ff8c-4a04-ac1adebed72e@perex.cz>
References: <f9918709be17e4289c0d667b15187f88985a145c.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2BB1EF800DE
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2019 16:21:05 +0200 (CEST)
In-Reply-To: <f9918709be17e4289c0d667b15187f88985a145c.camel@nxp.com>
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
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: Carol Zhu <carol.zhu@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Jun Zhu <junzhu@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 01. 07. 19 v 15:31 Daniel Baluta napsal(a):
> Hi Jaroslav,
> 
> What are trying to understand where are the official ALSA project
> repos.
> 
> We found:
>  - Github: https://github.com/alsa-project
> and
>  - alsa-project.org: https://git.alsa-project.org/
> 
> Which one should we use for our daily builds?
> 
> For example we have been using alsa-project.org repo for tinycompress.
> But in the last few days git clone didn't work! Now it seems to be back
> 
> online.
> 
> Also, we are using Yocto poky recipes:
> 
> 
> http://git.yoctoproject.org/cgit.cgi/poky/tree/meta/recipes-multimedia/alsa/alsa-lib_1.1.8.bb?h=warrior
> 
> which use pre-build archives from:
> 
> https://www.alsa-project.org/files/pub/
> 
> So, any clarifications on the release deliverables for ALSA project
> would be highly appreciated.

Hi all,

The alsa-project.org server is the official one. I am actually trying to
resolve the git server issues (seems that the stalled connections causes
this). The github is used as the development platform which may be switched to
another in the future.

Just ping me if you have any problem.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
