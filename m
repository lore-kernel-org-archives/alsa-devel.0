From: Marcus Andersson <054185595@telia.com>
Subject: Re: hdsp and midi problems
Date: Mon, 23 Jun 2003 17:53:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EF72262.EF180410@telia.com>
References: <NDBBLGIKBJENLAMOLFHGOEPKCIAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Mark Knecht wrote:
> 
> Marcus,
>    The HDSP 9652 MIDI interface has (for me under Linux) always dropped lots
> of notes. Mostly I find it interesting that it drops note off information
> and doesn't seem to drop note-on.

That is probably just a conincident depending on the read
pattern/processor load of your applications. Now it's just a matter of
convincing someone to debug it. I might even do it myself. If the ALSA
CVS would just compile. I have never experienced a project that cares so
little about code checked in being compilable. Frustrating.

>    The same machine booted into Windows runs perfectly, so I'm pretty sure
> it's not a hardware issue.

Mine works as well.

Marcus


-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
