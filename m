From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [alsa-cvslog] alsa-lib: Remove indirect control
	access
Date: Tue, 22 Jan 2008 17:20:28 +0100
Message-ID: <m2ir1lq1bn.fsf@vador.mandriva.com>
References: <ALOGGER1199813641.13@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mandriva.com (mx1.mandriva.com [212.85.150.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 34D5824B5B
	for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2008 17:20:37 +0100 (CET)
In-Reply-To: <ALOGGER1199813641.13@alsa-project.org> (Takashi Iwai's message
	of "Tue\, 8 Jan 2008 18\:34\:01 +0100 \(CET\)")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> changeset:   2374:d0e6c6e079eb
> user:        tiwai
> date:        Tue Jan 08 18:34:36 2008 +0100
> files:       include/sound/asound.h src/control/control.c
> description:
> Remove indirect control access
> 
> The indirect control access is removed from the kernel.
> This patch cleans the corresponding alsa-lib part.

Shouldn't this be kept for compatibility with older kernels?
Eg: if someone update distro foobar from version X to version Y, he
usually can boot either the old kernel from X or the new one from Y.

With such a change, booting the older kernel would result in missing
features, wouldn't it?
