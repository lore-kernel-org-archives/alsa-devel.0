From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: snd_hda_intel: Conexant CX20551 (Waikiki)
Date: Sun, 03 Jun 2007 08:33:22 -0700
Message-ID: <1180884802.4335.74.camel@razman.gruemaster.com>
References: <9a85a1550706030812s61d5112dk45e735ca82e28ac6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 96ED5244B2
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Jun 2007 19:14:16 +0200 (CEST)
In-Reply-To: <9a85a1550706030812s61d5112dk45e735ca82e28ac6@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Edwin Smulders <edwin.smulders@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a known acpi issue with Toshiba (I can tell by the subsystem id:
1179:ff31 for device 0:1b.0).   Here are a few links to help fix the
problem:

http://www.linuxquestions.org/questions/showthread.php?t=531575
http://gentoo-wiki.com/HARDWARE_Toshiba_Satellite_P100


Tobin

On Sun, 2007-06-03 at 17:12 +0200, Edwin Smulders wrote:

> Hi,
> 
> I believe there's still a problem with the HDA Intel chip Conexant
> CX20551 (Waikiki) not working.
> However, im not entirely sure the problem the problem is with alsa,
> because it starts working when i boot with acpi=off (a fix suggested
> on the ubuntu forums, but not quite useful on a laptop [plus, it
> breaks my ethernet])
> 
> The reason I'm mailing is, can you confirm this is something alsa
> can/should/will fix or are we all looking in the wrong direction and
> this is really an acpi problem?
> 
> If you can fix this or know of something that might work, I would be
> happy to hear it.
> I've attached my lspci -nv and cat /proc/asound/card0/codec\#* just in
> case. I would be happy to give you any more info you might need.
> 
> ~~ Edwin
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>
