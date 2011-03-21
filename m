From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 7/16] ALSA: VIA HDA: Modify
 notify_aa_path_ctls() function
Date: Mon, 21 Mar 2011 08:32:43 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1103210832030.4805@eeebox2.perex-int.cz>
References: <4D86FE5F.9030106@viatech.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id AF64710388D
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 08:32:44 +0100 (CET)
In-Reply-To: <4D86FE5F.9030106@viatech.com.cn>
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

On Mon, 21 Mar 2011, Lydia Wang wrote:

> From: Lydia Wang <lydiawang@viatech.com.cn>
> Subject: ALSA: VIA HDA: Modify notify_aa_path_ctls() function.
>
> Modify notify_aa_path_ctls() function to get volume control items name
> dynamically instead of by giving static item name.

This code looks ugly to me. If you like to have a dynamic set of notified 
controls, create one using snd_array in via_spec.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
