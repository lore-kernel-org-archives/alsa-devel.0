From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] sound: Retire OSS
Date: Mon, 30 Oct 2017 20:31:38 +0100
Message-ID: <83028545-9b12-4f43-1f31-46c18cd16681@perex.cz>
References: <s5hwp3cr86f.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id F2F18266CED
 for <alsa-devel@alsa-project.org>; Mon, 30 Oct 2017 20:31:40 +0100 (CET)
In-Reply-To: <s5hwp3cr86f.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dne 30.10.2017 v 16:01 Takashi Iwai napsal(a):
> Hi,
> 
> below is a snippet of the patch I'm going to apply for finally
> dropping the OSS code.  It's been already disabled for a few kernel
> versions, and we didn't get any complains.  So, as discussed in the
> last audio mini-summit, we go forward now.
> 
> Since the whole patch just removing a bunch of files is too big to
> post (and useless), I attach only a part of it: namely, the changelog,
> the diffstat, and the files that are modified (but not deleted).

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
