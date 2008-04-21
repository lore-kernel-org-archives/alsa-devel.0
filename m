From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: snd_pcm_rewind() weirdness
Date: Mon, 21 Apr 2008 08:58:49 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0804210855520.7882@tm8103.perex-int.cz>
References: <20080419233738.GA18371@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 49B6A244AF
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Apr 2008 08:58:50 +0200 (CEST)
In-Reply-To: <20080419233738.GA18371@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lennart Poettering <mznyfn@0pointer.de>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 20 Apr 2008, Lennart Poettering wrote:

> Hey!
> 
> On ALSA 1.0.16 with the HDA driver I am experiencing some weird things
> with snd_pcm_rewind() which I think are the result of a kernel bug,
> but I am not sure.

What alsa-lib plugins are on path? It looks like a rate plugin issue. Post 
also snd_pcm_dump() output. Driver does not do any alignment.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
