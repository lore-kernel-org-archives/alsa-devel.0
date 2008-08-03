From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: dmix in a forked process
Date: Sun, 3 Aug 2008 20:38:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0808032036330.31850@tm8103-a.perex-int.cz>
References: <4eccebac0808012003j49ea4351pc34f3f1ed7690f15@mail.gmail.com>
	<4eccebac0808021945s66b362e3u51ecedea830a04e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DD392475A
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Aug 2008 20:38:55 +0200 (CEST)
In-Reply-To: <4eccebac0808021945s66b362e3u51ecedea830a04e4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Bankim Bhavsar <bankim.bhavsar@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sat, 2 Aug 2008, Bankim Bhavsar wrote:

> I'm currently porting the sound code of our app from OSS to ALSA but
> this problem is preventing me from doing so.
> Is there any way to get around this problem?

What's your problem with fork()? I don't see the reason, why fork should 
be avoided. The server_job() process ends when the last application closes 
shared device. It's just management task to manage and release resources 
shared among audio processes.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
