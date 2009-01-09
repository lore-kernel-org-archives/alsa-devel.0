From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 0/7] ASoc updates for -next
Date: Fri, 9 Jan 2009 11:55:43 +0000
Message-ID: <20090109115542.GB25751@sirena.org.uk>
References: <20090108193718.GA29183@sirena.org.uk>
	<s5h4p093pwn.wl%tiwai@suse.de>
	<20090109084335.GA30639@sirena.org.uk>
	<s5htz883lku.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A416103804
	for <alsa-devel@alsa-project.org>; Fri,  9 Jan 2009 12:55:44 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5htz883lku.wl%tiwai@suse.de>
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

On Fri, Jan 09, 2009 at 09:55:29AM +0100, Takashi Iwai wrote:

> Well, in this case, it's more logical to merge them into 2.6.29
> because that API change was introduced first on 2.6.29, and then we
> are now trying to kill it again.  By merging the clean-up patches,
> such an intermediate API change will be gone gracefully.

Yeah, I agree entirely - the cases I was thinking of were similar things
like the pop wait timer which was only in sysfs for one kernel release.
