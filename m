From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 7/7] ALSA: VIA HDA: Fix VT1708 can't build
 up Headphone control issue
Date: Tue, 22 Mar 2011 09:33:08 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103220931430.4805@eeebox2.perex-int.cz>
References: <4D885D3C.8080309@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 380091038FD
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2011 09:33:10 +0100 (CET)
In-Reply-To: <4D885D3C.8080309@viatech.com.cn>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lydia Wang <lydiawang@viatech.com.cn>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, HaraldWelte@viatech.com
List-Id: alsa-devel@alsa-project.org

On Tue, 22 Mar 2011, Lydia Wang wrote:

> From: Lydia Wang <lydiawang@viatech.com.cn>
> Subject: ALSA: VIA HDA: Fix VT1708 can't build up Headphone control issue.
>
> Since VT1708 didn't support the control of getting connection number,
> building of headphone control will fail in via_hp_build() function.

I would move the declaration of 'nums' variable to the if {} section here.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
