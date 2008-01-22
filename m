From: Thierry Vignaud <tvignaud@mandriva.com>
Subject: Re: [alsa-cvslog] alsa-lib: Remove indirect control
	access
Date: Tue, 22 Jan 2008 17:29:32 +0100
Message-ID: <m2abmxq0wj.fsf@vador.mandriva.com>
References: <ALOGGER1199813641.13@alsa-project.org>
	<m2ir1lq1bn.fsf@vador.mandriva.com> <s5h63xl968q.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mandriva.com (mx1.mandriva.com [212.85.150.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 47D1924B63
	for <alsa-devel@alsa-project.org>; Tue, 22 Jan 2008 17:29:37 +0100 (CET)
In-Reply-To: <s5h63xl968q.wl%tiwai@suse.de> (Takashi Iwai's message of "Tue\,
	22 Jan 2008 17\:26\:13 +0100")
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> writes:

> > > description:
> > > Remove indirect control access
> > > 
> > > The indirect control access is removed from the kernel.
> > > This patch cleans the corresponding alsa-lib part.
> > 
> > Shouldn't this be kept for compatibility with older kernels?
> > Eg: if someone update distro foobar from version X to version Y,
> > he usually can boot either the old kernel from X or the new one
> > from Y.
> > 
> > With such a change, booting the older kernel would result in
> > missing features, wouldn't it?
> 
> This feature isn't really implemented in alsa-lib API, too.
> So, you couldn't use this feature anyway.

OK.
