From: Damien Zammit <damien.zammit@gmail.com>
Subject: Need help compiling alsa-kernel from git
Date: Fri, 21 Aug 2009 16:58:47 +1000
Message-ID: <98ec50f0908202358j1233d47ci9c7e1e64873a956b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f220.google.com (mail-ew0-f220.google.com
	[209.85.219.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A744103897
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Aug 2009 08:58:47 +0200 (CEST)
Received: by ewy20 with SMTP id 20so477006ewy.46
	for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2009 23:58:47 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

I downloaded a 2.6.30.4 vanilla kernel source tree, merged it with alsa 1.0.20
by copying the files into my kernel source tree, and used that as a
base for modifying a sound driver module.

I want to submit a patch because I got a new device working.
I cloned alsa-kernel git and merged my changes into the tree and committed it.

Now, how do I compile it to test it? Do I need to clone linux-2.6 git?
I would prefer not to clone that whole tree if possible...
I tried copying the sound directory from my working alsa-kernel git
tree into a 2.6.30.4 vanilla kernel tree,
but it doesnt work.

Please help.
