From: Daniel Baluta <daniel.baluta@nxp.com>
Subject: ALSA repos
Date: Mon, 1 Jul 2019 13:31:21 +0000
Message-ID: <f9918709be17e4289c0d667b15187f88985a145c.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-eopbgr00082.outbound.protection.outlook.com [40.107.0.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02F29F8076A
 for <alsa-devel@alsa-project.org>; Mon,  1 Jul 2019 15:31:22 +0200 (CEST)
Content-Language: en-US
Content-ID: <7F6A40B39097AD4B9A8BA412EF70F20B@eurprd04.prod.outlook.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: "perex@perex.cz" <perex@perex.cz>
Cc: Carol Zhu <carol.zhu@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Jun Zhu <junzhu@nxp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Jaroslav,

What are trying to understand where are the official ALSA project
repos.

We found:
 - Github: https://github.com/alsa-project
and
 - alsa-project.org: https://git.alsa-project.org/

Which one should we use for our daily builds?

For example we have been using alsa-project.org repo for tinycompress.
But in the last few days git clone didn't work! Now it seems to be back

online.

Also, we are using Yocto poky recipes:


http://git.yoctoproject.org/cgit.cgi/poky/tree/meta/recipes-multimedia/alsa/alsa-lib_1.1.8.bb?h=warrior

which use pre-build archives from:

https://www.alsa-project.org/files/pub/

So, any clarifications on the release deliverables for ALSA project
would be highly appreciated.

thanks,
Daniel.
