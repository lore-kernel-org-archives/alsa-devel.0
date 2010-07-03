From: David Dillow <dave@thedillows.org>
Subject: Re: [PATCH] sis7019: fix capture issues with multiple
 periods per buffer
Date: Fri, 02 Jul 2010 23:12:10 -0400
Message-ID: <1278126730.4311.3.camel@obelisk.thedillows.org>
References: <1277589872.2438.5.camel@obelisk.thedillows.org>
	<1277649968.2438.34.camel@obelisk.thedillows.org>
	<1277703222.2438.184.camel@obelisk.thedillows.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from amavis-smtp.knology.net (amavis-smtp.knology.net [75.76.199.6])
	by alsa0.perex.cz (Postfix) with ESMTP id 496882447F
	for <alsa-devel@alsa-project.org>;
	Sat,  3 Jul 2010 05:12:19 +0200 (CEST)
In-Reply-To: <1277703222.2438.184.camel@obelisk.thedillows.org>
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
Cc: tiwai@suse.de, linux@schou.dk
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-06-28 at 01:33 -0400, David Dillow wrote:
> Ok, definitely different problem, as it dies 12:15 into a run using 2
> periods per buffer, so the virtual timing code does not come into it.
> Interestingly enough, it died after ~44092 seconds while recording at
> 44100 Hz.
> 
> The patch should be applied. If and when I find the source of this new
> bug, I'll submit a separate patch.

For the Google record: this was the boundary wrap issue fixed by Clemens
Ladisch in b406e6103baa3da85950f22d3d46d21a8da654c5. It's survived many
boundary crossings with a shorted setting (256 seconds at 48kHz) so I'm
very confident.

And I went with 2.6.34 to avoid the potential of instabilities in the
2.6.35-rc series. Oops :)
