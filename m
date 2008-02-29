From: "Demian Martin" <demianm@attglobal.net>
Subject: Re: How to set idle S/PDIF sample rate?
Date: Thu, 28 Feb 2008 22:02:50 -0800
Message-ID: <00c701c87a98$b7cf6860$d450a8c0@PDSMain2>
References: <mailman.2237.1204248430.2095.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n17.bullet.mail.mud.yahoo.com (n17.bullet.mail.mud.yahoo.com
	[68.142.201.234]) by alsa0.perex.cz (Postfix) with SMTP id 49AC4246C1
	for <alsa-devel@alsa-project.org>; Fri, 29 Feb 2008 07:07:01 +0100 (CET)
In-Reply-To: <mailman.2237.1204248430.2095.alsa-devel@alsa-project.org>
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
Cc: 'Kirill Belokurov' <kirill.b@plutohome.com>
List-Id: alsa-devel@alsa-project.org

I noticed another big problem in my application relating to locking the
system at 48 KHz in the background. If I set SPDIF to 44.1KHz on some
playback software (Xine for example) between tracks the system briefly
switches back to 48 KHz. This causes an audible pop as the external DAC
tries to keep up with the rate change. I have not found a way to lock the
system at a different rate (44100 for example) so this doesn't happen
between tracks. This behavior is common to both the ICE1724 and the VT1708
drivers. 
       -Demian



Date: Thu, 28 Feb 2008 16:12:10 -0500
From: Matt Whitlock <matt@whitlock.name>
Subject: Re: [alsa-devel] How to set idle S/PDIF sample rate?
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
Message-ID: <200802281612.11099.matt@whitlock.name>
Content-Type: text/plain;  charset="iso-8859-1"

On Thursday, 28 February 2008 6:43:25 am Takashi Iwai wrote:
> The driver code resets the format verb of the relevant widgets at 
> closing streams.  This verb contains the sample rate, too.  Maybe 
> keeping this would prevent the reset.
> 
> The below is a test patch.  Give it a try.

Wow, fantastic.  I will give this patch a try.  I'll have to rebuild my
kernel to disable the in-kernel ALSA code and build the ALSA module
separately from the latest sources, but if this patch fixes things, that
would be worth the effort.  I'll get back to you.  Thanks.

-Matt
