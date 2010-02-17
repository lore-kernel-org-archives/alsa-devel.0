From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: safe support for rewind in ALSA
Date: Wed, 17 Feb 2010 16:30:24 +0100
Message-ID: <20100217153024.GA6891@tango.0pointer.de>
References: <6160a5131002010920j4417a34ai9f410fb500f7f305@mail.gmail.com>
	<alpine.LNX.2.00.1002011840020.25340@eeebox2.perex-int.cz>
	<4f3252891002060359j11d68819idf5d12705e2a60bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 10DA0103892
	for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2010 16:30:51 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <4f3252891002060359j11d68819idf5d12705e2a60bc@mail.gmail.com>
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

On Sat, 06.02.10 19:59, Raymond Yau (superquad.vortex2@gmail.com) wrote:

> How about those alsa plugins ( e.g. pulse , jack , oss , .... )
> 
> Can alsa application use snd_pcm_rewind() for pulse plugin or oss plugin ?

If your question is wether the PA plugin for libasound supports
snd_pcm_rewind(), then the answer is no, it doesn't. I am not even
sure the ioplug stuff would even allow that as it stands now.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
