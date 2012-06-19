From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
Subject: Re: [RFC PATCH] Inverted internal mic
Date: Tue, 19 Jun 2012 03:07:40 +0000 (UTC)
Message-ID: <loom.20120619T050139-760@post.gmane.org>
References: <4F4C9714.1080307@canonical.com> <s5haa43ux7u.wl%tiwai@suse.de>
	<4F4CA438.90103@canonical.com> <s5hvcmrp7ji.wl%tiwai@suse.de>
	<4F4CD1AF.2050409@canonical.com> <s5hboojozx7.wl%tiwai@suse.de>
	<4F4CE264.7040008@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CA092436E
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2012 05:10:07 +0200 (CEST)
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1SgopQ-0001Vr-IP
	for alsa-devel@alsa-project.org; Tue, 19 Jun 2012 05:10:04 +0200
Received: from 121-72-250-62.cable.telstraclear.net ([121.72.250.62])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2012 05:10:04 +0200
Received: from eliot by 121-72-250-62.cable.telstraclear.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 19 Jun 2012 05:10:04 +0200
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

David Henningsson <david.henningsson <at> canonical.com> writes:
> On 02/28/2012 02:22 PM, Takashi Iwai wrote:
> > At Tue, 28 Feb 2012 14:07:59 +0100,
> > David Henningsson wrote:
> > Is there a way we can
> >> know the corresponding processing coefficients to set for ALC268 and
> >> ALC272X as well?
> >
> > AFAIK, no, it was specific to the codec model.
> 
> Ok, then we can only hope for Kailang to supply this information if 
> possible. And if not possible we could attempt the workaround (when/if 
> we agree on it...) for these devices as well?

Greetings,

Any chance that there has been any progress on this?
I have a machine with dmic and ALC272X (details below) that exhibits this
problem, and can test any proposed patch.

regards

--
Eliot

Machine details:
emachines 350
Codec: Realtek ALC272X
Vendor Id: 0x10ec0272
Subsystem Id: 0x10250349
Revision Id: 0x100001
