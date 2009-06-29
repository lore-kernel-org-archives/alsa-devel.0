From: Paul Fertser <fercerpav@gmail.com>
Subject: External PCM hook SO is dlclosed after calling install,
	making it	hard to have hooks in it
Date: Tue, 30 Jun 2009 02:11:01 +0400
Message-ID: <20090629221101.GD23025@home.pavel.comp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 79D1210380C
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Jun 2009 00:11:54 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 13so574640fge.21
	for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2009 15:11:53 -0700 (PDT)
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
Cc: Joerg Reisenweber <joerg@openmoko.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I've tried to implement an external shared object to be able to
execute arbitrary functions on PCM device opening and closing. After
quite some source code reading i had an almost working but segfaulting
example. This segfault is because snd_dlclose is called right after
calling a hook install function and therefore i can't snd_pcm_hook_add
functions from the same shared object. To me it looks like a bug but
probably i just don't see how this functionality is intended to be
used. Takashi, git-blame showed that it's you who stuffed this dlclose
call that bothers me ;)

TIA

Background information:

We're working on audio subsystem for OpenMoko Freerunner. It's an idea
of Joerg Reisenweber to have virtual alsa devices for every reasonable
use-case (like dedicated device for stereout, dedicated device for
recording from gsm etc), for that we need a hook on every device
opening and closing mostly to set up routing inside WM8753
codec. ctl_elems is not enough because we need a more complex locking
scheme (with priorities, some kind of callbacks to the apps using
particular devices etc) and other flexibility.

-- 
Be free, use free (http://www.gnu.org/philosophy/free-sw.html) software!
mailto:fercerpav@gmail.com
