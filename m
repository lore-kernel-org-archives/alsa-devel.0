From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: hdsp and midi problems
Date: Mon, 23 Jun 2003 06:38:20 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGOEPKCIAB.mknecht@controlnet.com>
References: <3EF4BCA2.578FD128@telia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EF4BCA2.578FD128@telia.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Marcus Andersson <054185595@telia.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
> More information,
>
> when I run the program with 100% load using my VIA motherboard midi, I
> loose no bytes as far as I can see.
>
> I use alsa 0.9.4
>
> Marcus

Marcus,
   The HDSP 9652 MIDI interface has (for me under Linux) always dropped lots
of notes. Mostly I find it interesting that it drops note off information
and doesn't seem to drop note-on. I cannot be sure how well it handles
controller information.

   The same machine booted into Windows runs perfectly, so I'm pretty sure
it's not a hardware issue.

Mark




-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
