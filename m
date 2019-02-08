From: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
Subject: Re: [PATCH] ALSA: pcm: Revert capture stream behavior
 change in blocking mode
Date: Fri, 8 Feb 2019 15:46:12 -0200
Message-ID: <20190208174612.GA838@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by alsa0.perex.cz (Postfix) with ESMTP id CD26E267437
 for <alsa-devel@alsa-project.org>; Fri,  8 Feb 2019 18:46:18 +0100 (CET)
Received: by mail-qk1-f194.google.com with SMTP id r21so2584092qkl.11
 for <alsa-devel@alsa-project.org>; Fri, 08 Feb 2019 09:46:18 -0800 (PST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> e.g. one thread goes to a write loop in blocking mode while another
> thread controls the start/stop of the stream manually.

You meant a read loop. Agreed.

What about adding a comment like:

/*
 * If size < start_threshold, wait indefinitely. Another
 * thread may start capture
 */

So no one will bring this idea again.

	pasquali
