From: Chris Mennie <cmennie@rogers.com>
Subject: Re: [PATCH] Support for Roland SonicCell sound module
Date: Mon, 19 May 2008 09:47:52 -0400
Message-ID: <200805190947.52616.cmennie@rogers.com>
References: <200805181322.11486.cmennie@rogers.com>
	<200805190911.36728.cmennie@rogers.com>
	<s5hwslqbfhd.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp118.rog.mail.re2.yahoo.com (smtp118.rog.mail.re2.yahoo.com
	[68.142.225.234]) by alsa0.perex.cz (Postfix) with SMTP id 61F092462B
	for <alsa-devel@alsa-project.org>;
	Mon, 19 May 2008 15:47:55 +0200 (CEST)
In-Reply-To: <s5hwslqbfhd.wl%tiwai@suse.de>
Content-Disposition: inline
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

> Well, usually the patch must be signed off by the author to be merged
> to the upstream for avoiding possible legal and other problems.
> See Documentation/SubmittingPatches in Linux kernel tree for details.
>
> About the changelog, I prefer a bit more descrictive one.

	Ok, how about this:

	Added entry into usbquirks.h to recognize Roland SonicCell sound module by 
mostly duplicating the entry for the Roland SH-201. USB MIDI works just fine, 
though the USB audio is a little unreliable (but still works well enough).

	Signed-off-by: Chris Mennie <camennie at alumni dot uwaterloo dot ca>
