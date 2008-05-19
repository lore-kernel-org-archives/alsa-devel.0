From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: pyalsa with threads allowed for python
 (Py_BEGIN_ALLOW_THREADS & Py_END_ALLOW_THREADS)
Date: Mon, 19 May 2008 08:45:56 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0805190845380.8099@tm8103.perex-int.cz>
References: <95e4e4ce0805170940wb1aa76et3003ab926bfe03eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id A2B202456D
	for <alsa-devel@alsa-project.org>;
	Mon, 19 May 2008 08:45:57 +0200 (CEST)
In-Reply-To: <95e4e4ce0805170940wb1aa76et3003ab926bfe03eb@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "ki.ber.kom.uni.st" <ki.ber@kom.uni.st>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 17 May 2008, ki.ber.kom.uni.st wrote:

> the other solution is in particular case of receive_events to put
> Py_*_ALLOW_THREADS
> 
>     Py_BEGIN_ALLOW_THREADS;
>     ret = poll(self->receive_fds, self->receive_max, timeout);
>     Py_END_ALLOW_THREADS;

Added to our repository. Thanks.

					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
