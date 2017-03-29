From: Max Kellermann <max@duempel.org>
Subject: Re: dmix, snd_pcm_drain(), SND_PCM_NONBLOCK - bug?
Date: Wed, 29 Mar 2017 19:59:27 +0200
Message-ID: <20170329175927.GA27507@swift.blarg.de>
References: <20170316122336.GA7038@swift.blarg.de>
 <s5h4lyol7ob.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swift.blarg.de (swift.blarg.de [78.47.110.205])
 by alsa0.perex.cz (Postfix) with ESMTP id 702B226701C
 for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2017 19:59:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5h4lyol7ob.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 2017/03/20 08:38, Takashi Iwai <tiwai@suse.de> wrote:
> Yeah, the code is obviously wrong.  And it seems that now Jaroslav
> already fixed the issue in git repo.  Please give it a try.

The bug reporter confirmed that this commit fixes his MPD problem.
Thanks.

Max
