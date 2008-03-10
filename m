From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: aplay: can't resolve symbol 'snd_dlsym_start
Date: Mon, 10 Mar 2008 13:41:10 -0700
Message-ID: <61445c750803101341m30db6b1oa518c32cdd7fc437@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from gv-out-0910.google.com (gv-out-0910.google.com [216.239.58.188])
	by alsa0.perex.cz (Postfix) with ESMTP id E4D932449E
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2008 21:41:13 +0100 (CET)
Received: by gv-out-0910.google.com with SMTP id c6so670293gvd.24
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2008 13:41:13 -0700 (PDT)
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

Hi,

I have written an user space plugin and the plugin shared library is
copied on board
appropriately, libasound.so is also copied.


When I try:

#aplay -D omx    test.wav  //omx is my plugin

I get following error:

aplay: can't resolve symbol 'snd_dlsym_start


Any idea what is the problem?

-pharaoh
