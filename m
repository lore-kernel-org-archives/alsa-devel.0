From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Master Plan on rewinding
Date: Tue, 09 Sep 2014 10:43:11 +0200
Message-ID: <540EBD9F.5090202@ladisch.de>
References: <540C76E0.9050808@gmail.com> <540D61C4.90206@canonical.com>
 <540D6CFE.808@gmail.com> <540D7647.6040704@canonical.com>
 <540D830E.70802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id CCD23264F1A
 for <alsa-devel@alsa-project.org>; Tue,  9 Sep 2014 10:43:13 +0200 (CEST)
In-Reply-To: <540D830E.70802@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, David Henningsson <david.henningsson@canonical.com>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Alexander E. Patrakov wrote:
> This phrase from the documentation of snd_pcm_rewindable is also
> something to think about:
>
> """
> Note: The snd_pcm_rewind() can accept bigger value than returned by
> this function. But it is not guaranteed that output stream will be
> consistent with bigger value.

This phrase again assumes a ring buffer, i.e., it says that
1) there is a buffer, and applications can write _anywhere_ in it, but
2) if a plugin reduces the allowed range (with snd_pcm_rewindable()),
   it is likely that the plugin will not notice that some part of the
   buffer has changed.

(The first part is not true for most unrewindable plugins.)


Regards,
Clemens
