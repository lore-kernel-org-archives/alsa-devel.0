From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] ALSA: hda: Fixup commit 79c944ad (caused
 codec initialization failure)
Date: Tue, 27 Jul 2010 10:01:12 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1007270953350.4068@eeebox2.perex-int.cz>
References: <4C4E0A45.3070008@canonical.com> <s5hbp9ta3lo.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 641D624435
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jul 2010 10:01:13 +0200 (CEST)
In-Reply-To: <s5hbp9ta3lo.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 27 Jul 2010, Takashi Iwai wrote:

> At Tue, 27 Jul 2010 00:20:53 +0200,
> David Henningsson wrote:
>>
>> [1  <text/plain; ISO-8859-1 (7bit)>]
>> A recent commit in current HEAD (79c944ad) caused codecs not to be
>> detected in some cases, found on several Realtek codecs.
>>
>> Please apply the attached fix for that problem.
>
> Ah, I forgot about this being committed to topic/misc branch since
> Jaroslav's branch contains more other stuff than HD-audio.
>
> Applied now.  Thanks for tracking down.

I fixed it in this commit on 20 Jul:

http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=cd7643bfb772dc7103ed6fc8dda6b233a8e14178

Could you revert this patch and pull from my devel tree?

 				Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
