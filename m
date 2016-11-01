From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question about the buffer length in the
	transfer	callback of the PCM External Plugin
Date: Tue, 1 Nov 2016 12:49:13 +0100
Message-ID: <2dc2c73c-9d7c-3d3e-4d23-9797de2d1ec4@ladisch.de>
References: <a68475dd084f4a45b224791224c7c244@LGNMSXB01.prod.bk.dfs>
 <19904f93-f0ba-56a9-2980-ed52fe2a32bb@ladisch.de>
 <6c2af613d3b64138bc6e7c6cf69486cf@LGNMSXB01.prod.bk.dfs>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 6657E2666E3
 for <alsa-devel@alsa-project.org>; Tue,  1 Nov 2016 12:49:17 +0100 (CET)
In-Reply-To: <6c2af613d3b64138bc6e7c6cf69486cf@LGNMSXB01.prod.bk.dfs>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Bach, Andrea" <andrea.bach@dfs.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Bach, Andrea wrote:
> Ok, what about the output buffer?

"Output" from which point of view?  Playback or capture?

> When just 960 bytes are ready to be returned but I have to return 1000 bytes?

In theory, this is an underrun.

You could wait until the next 40 bytes are available.


Regards,
Clemens
