From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: Problems with pulseaudio / asla on PS3
Date: Mon, 8 Sep 2008 22:21:36 +0200
Message-ID: <20080908202135.GA5221@tango.0pointer.de>
References: <200809050842.08596.kevin952@tpg.com.au>
	<s5hwshrt84y.wl%tiwai@suse.de>
	<200809052102.06534.kevin952@tpg.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id B70C92435D
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 22:21:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809052102.06534.kevin952@tpg.com.au>
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
List-Id: alsa-devel@alsa-project.org

On Fri, 05.09.08 21:02, Kevin Gilbert (kevin952@tpg.com.au) wrote:

> 
> Hi Takashi,
> 
> On Fri, 5 Sep 2008, Takashi Iwai opined:
> > Well, it's no bug in softvol, at least.  The softvol doesn't do any
> > format or layout conversions.  The layout conversion is done via plug
> > plugin applied onto the softvol.
> 
> OK (not that I fully understand what you have said) but where does that leave 
> me? Is there something that I should try? Some ALSA or kernel configuration 
> option that might be in error?

Takashi, as Kevin wrote originally, the problem is not that softvol
doesn't do any format/layout conversions, but that it claims it
does. PA asks softvol for INTERLEAVED samples, softvol agrees to
that -- and actually hands us only NONINTERLEAVED samples because it
doesn't reformat the from the underlying layer.

So, it *is* a bug in softvol. However, you are right that it doesn't
do any conversions.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
