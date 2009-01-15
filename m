From: Ian Molton <ian@mnementh.co.uk>
Subject: Re: [Pull request] Support for wm9705 codec and two
 machines that use it.
Date: Thu, 15 Jan 2009 10:47:49 +0000
Message-ID: <496F1455.7040106@mnementh.co.uk>
References: <496E8DD0.4090006@mnementh.co.uk>
	<s5hfxjl3v6s.wl%tiwai@suse.de>	<496F0ABD.4080207@mnementh.co.uk>
	<20090115101018.GK2162@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mnementh.co.uk (mail.mnementh.co.uk [173.45.232.4])
	by alsa0.perex.cz (Postfix) with ESMTP id DDC30243BF
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 11:47:25 +0100 (CET)
In-Reply-To: <20090115101018.GK2162@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Russell King - ARM Linux wrote:
> Only one comment from me...

<cut>

> Please do not include linux/version.h except where it is really needed
> (I don't see anything requiring it in this file.)

Change made and pushed out.
