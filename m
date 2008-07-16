From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [Alsa-user] is this card supported by ALSA?
Date: Wed, 16 Jul 2008 16:52:39 +0200
Message-ID: <487E0B37.9050609@keyaccess.nl>
References: <BLU137-W200E329BE55D7983681A9958F0@phx.gbl>
	<487E0854.6010203@keyaccess.nl> <487E093B.30601@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.groni1.gr.home.nl (smtpq2.groni1.gr.home.nl
	[213.51.130.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 14CF5244BA
	for <alsa-devel@alsa-project.org>;
	Wed, 16 Jul 2008 16:50:46 +0200 (CEST)
In-Reply-To: <487E093B.30601@keyaccess.nl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Landis McGauhey <b3zdomny@hotmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-user@lists.sourceforge.net, devel <alsa-devel@alsa-project.org>, ALSA@sc8-sf-spam2.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 16-07-08 16:44, Rene Herman wrote:

> On 16-07-08 16:40, Rene Herman wrote:
> 
>> # moodprobe -r  ens1371-ac97_reset_hack.diff
>> # moodprobe -r  ens1371-ac97.diff
> 
> I'm getting really sick of the fact that I seem to need to make at least 
> one typo or other small error per post. "modprobe" ofcourse.

Oh, I so love myself. Try this instead:

# patch -p1 -r < ens1371-ac97_reset_hack.diff
# patch -p1 -r < ens1371-ac97.diff

I'll make sure I get some sleep before I post again.

Rene.
