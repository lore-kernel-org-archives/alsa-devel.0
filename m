From: "Aaron \"Caustik\" Robinson" <caustik@gmail.com>
Subject: dmix and sounds less than 64kb
Date: Fri, 6 Jul 2007 20:28:13 -0700
Message-ID: <61e8390b0707062028t63c913eeg1ab5a40f830af597@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.189])
	by alsa0.perex.cz (Postfix) with ESMTP id 242F71037F3
	for <alsa-devel@alsa-project.org>;
	Sat,  7 Jul 2007 05:28:15 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so47028mue
	for <alsa-devel@alsa-project.org>; Fri, 06 Jul 2007 20:28:14 -0700 (PDT)
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
List-Id: alsa-devel@alsa-project.org

We have been having one heck of a time tracking down the cause of some ALSA
audio playback issues.

It appears that any time we play a very short sound (<64kb), either the
sound doesn't play at all, or only a fragment of it plays. We haven't had
much luck finding a solution to this issue, then I found this thread on the
history of this email group:

http://mailman.alsa-project.org/pipermail/alsa-devel/2007-April/000526.html

Our problem is pretty much exactly like his issues relating to <64k sounds.

My question is - has anybody else run into this problem? To the OP of the
above thread, if you're still listening - did you ever find a solution to
your problem? I'd be very interested to hear any help you can provide.

Thanks much,
caustik
