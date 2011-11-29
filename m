From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Tests of the hda-jack branch
Date: Tue, 29 Nov 2011 20:03:51 +0000
Message-ID: <20111129200351.GF12111@sirena.org.uk>
References: <4ED535CA.1080108@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 44F1724523
	for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2011 21:03:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4ED535CA.1080108@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 29, 2011 at 08:43:06PM +0100, David Henningsson wrote:

> What are your thoughts on how to proceed, when do you think this is
> ready to be merged into the topic/hda branch?

I'm still rather sad that this infrastructure is all totally separate to
the existing jack infrastructure, one of the goals of having common
infrastructure was to insulate drivers from having to deal with changes
in the APIs used for reporting and I certainly don't want to have to
have all the drivers individually reporting via all the APIs (especially
not with the multiswitch API coming along too).

I've not really reviewed the code beyond noticing that, I'd been waiting
for it to turn up on the list.
