From: Aleksandar Kostadinov <akostadinov@friendofpooh.com>
Subject: default alsa pcm improvement
Date: Wed, 20 Jan 2010 21:20:40 +0200
Message-ID: <a886f3c11001201120x66595796y2ca5f3af35fef8c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f222.google.com (mail-fx0-f222.google.com
	[209.85.220.222])
	by alsa0.perex.cz (Postfix) with ESMTP id 94B9624654
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 20:20:42 +0100 (CET)
Received: by fxm22 with SMTP id 22so3022816fxm.22
	for <alsa-devel@alsa-project.org>; Wed, 20 Jan 2010 11:20:40 -0800 (PST)
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

Hello,

>From some time now ALSA is a real pleasure to use. Namely it works by
OOB and has lots of predefined useful PCMs so one doesn't need to be a
guru to do advanced operations.

I think that a small improvement in how default PCM is defined can
help users with multiple sound cards that like to use pure ALSA and
not some of the many available sound servers.
I want to be able to switch the default sound device easily in
asoundrc but the way the default pcm is defined makes this not very
straightforward. I like to use the definitions of default:<CARD> but
if I define "pcm.!default" in .asoundrc I lose the "default:<CARD>"
definition. I now can rename the "default" definition in default.conf
to someting like "defaultorg" and then reference it asoundrc but that
requires root as well change can possibly disappear after an alsa-lib
package upgrade. Or I can use the dmix and dsnoop predefined PCMs to
put together PCMs that I can later reference in my "pcm.!default"
definition but in this case one needs to know if the card needs
dsnoop/dmix and probably other tweaks that default.conf contains.
Additionally this needs to be done for every sound card one owns.

So I would suggest the "default" PCM as defined now in the
default.conf file to be renamed to something like "alsadefault". Then
"default" PCM should be an alias to the alsadefault pcm. This will be
backwards compatible to what users have now and owners of multiple
sound devices can define their "default" pcm in asoundrc referencing
the alsadefault pcm benefiting from the good work already done and not
have to mess with a complex asoundrc file or make changes to the
system configurations files.

Please CC me in replies because I'm not subscribed.

Thanks again for the cool work!
