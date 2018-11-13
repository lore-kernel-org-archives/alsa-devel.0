From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: HTTP GIT access to alsa-lib seems to be misaligned
Date: Tue, 13 Nov 2018 23:04:26 +0100
Message-ID: <a0edda7c-1e35-f6a4-6916-8a8c93dd6642@perex.cz>
References: <d0499705-8b84-3761-42f0-f4b3b311c6d0@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 4D2252677E4
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2018 23:04:36 +0100 (CET)
In-Reply-To: <d0499705-8b84-3761-42f0-f4b3b311c6d0@de.adit-jv.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timo Wischer <twischer@de.adit-jv.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 13.11.2018 v 11:26 Timo Wischer napsal(a):
> Hi all,
> 
> The master branch of
> 
> $ git clone http://git.alsa-project.org/http/alsa-lib.git
> 
> is a different one as of
> 
> $ git clone git://git.alsa-project.org/alsa-lib.git alsa-lib
> 
> 
> $ git log --graph --oneline http/master
> * dd2f6f8 update README
> * 9021f6c samples: make them work well

Did you try the clean cloning? It seems that you have refs from my wrong
push where I accidently pushed alsa-ci repo to alsa-lib. I cannot
confirm the mismatch for the fresh clone.

						Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
