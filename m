From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: RFC: Jack-detection control elements on HD-audio
Date: Fri, 19 Jun 2009 10:54:00 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0906191048150.3983@eeebox2.perex-int.cz>
References: <s5hk538ejj4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C13510389B
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Jun 2009 10:54:01 +0200 (CEST)
In-Reply-To: <s5hk538ejj4.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 19 Jun 2009, Takashi Iwai wrote:

> Hi,
>
> yet another thing I've worked recently on is a bit more generalized
> framework for jack-sense reporting for HD-audio.  This supersedes the
> existing jack-sense reporting via the input layer.  In addition, it
> gives the corresponding control elements.
>
> For example, you'll have "Jack HP-Out" (or a bit more verbose like
> "Jack HP-Out at Ext Rear") control via control API as well as other
> mixer controls.  This can notify when a jack is plugged/unplugged.
> But, another big win is that you can read the current pin sense just
> by reading this element.

Before definining such extension, I would really see to define standard 
control names in Documentation/ControlNames.txt file. It seems to me that 
most new drivers does not follow suggested naming. The document should be 
reviewed, of course.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
