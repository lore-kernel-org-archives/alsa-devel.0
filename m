From: Tomas Cernaj <tomas@cernaj.de>
Subject: Re: hda: broken PCM over spdif after AC3; suggestion
Date: Tue, 21 Oct 2008 13:54:54 +0200
Message-ID: <1224590094.17188.10.camel@trpazlik>
References: <1224549448.647.21.camel@trpazlik> <s5h3aiqa26m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.cernaj.de (lvps80-237-163-12.dedicated.hosteurope.de
	[80.237.163.12])
	by alsa0.perex.cz (Postfix) with ESMTP id B75AC103807
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 13:55:16 +0200 (CEST)
Received: from [192.168.1.35] (dslb-084-059-156-074.pools.arcor-ip.net
	[84.59.156.74])
	by mail.cernaj.de (Postfix) with ESMTP id 2295FC916001
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Oct 2008 13:54:57 +0200 (CEST)
In-Reply-To: <s5h3aiqa26m.wl%tiwai@suse.de>
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

Am Dienstag, den 21.10.2008, 08:32 +0200 schrieb Takashi Iwai:
[...]
> I didn't check the launchpad page yet, but did you set "IEC958 Default PCM"
> switch off?  Or, start AC3 stream first, then analog stream.
> 
> The "IEC958 Default PCM" switch determines whether the SPDIF stream is
> assigned to the "default" PCM or not.

Thank you for bringing me on the right track! Due to my using an old
driver there is no "IEC958 Default PCM" switch, but a little research
discovered that you've dealt with this problem in February already (see
http://thread.gmane.org/gmane.linux.alsa.devel/50989/focus=51486 ), and
the proposed solution to set
	defaults.pcm.dmix.format S16
in ~/.asoundrc works for me.

I'm going to update the drivers anyways, but I'm confident that it will
work now :-)

Again, thank you for your quick response!
Tomas
