From: Chris Rankin <rankincj@yahoo.com>
Subject: Hardware-accelerated OpenAL support with ALSA?
Date: Wed, 30 May 2007 23:29:34 +0100 (BST)
Message-ID: <686006.93309.qm@web52903.mail.re2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web52903.mail.re2.yahoo.com (web52903.mail.re2.yahoo.com
	[206.190.49.13]) by alsa0.perex.cz (Postfix) with SMTP id CA7E12452D
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2007 00:29:50 +0200 (CEST)
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
Cc: dino.puller@gmail.com, alsa-users@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I have been looking at getting OpenAL working on my machine, since OpenAL is the only way that
games under Windows Vista can now provide hardware-accelerated sound effects. This suggests that a
lot of PC games could be adding OpenAL support soon, which means that it would be handy if Linux
had an efficient native OpenAL implementation that Wine could wrap. Fedora Core does provide an
OpenAL library from www.openal.org, but it looks as if this library's ALSA backend does not
provide any hardware acceleration. (I have an "Audigy 2 ZS" sound card, which can at least support
hardware mixing.) Various alternative ALSA-based solutions do seem to exist on the Web, e.g.

http://dino.e4a.it/openal-alsa/

and

http://www.lost.org.uk/openal.html

However, it seems to me that OpenAL support would be better served as an actual ALSA package that
distros would be able to ship.

Are there any plans to provide official OpenAL support in ALSA, please?

Thanks for any information,
Chris

P.S. My Audigy 2 also seems to have EAX support. Does the ALSA driver support that functionality
too? I can't say that "World of Warcraft" seems to use it, although Wine's DirectSound3D support
still has lots of gaps.



      _________________________________________________________
Inbox cluttering up with junk? Clean up with Yahoo! Mail.
http://uk.docs.yahoo.com/mail/isp_targeting.html
