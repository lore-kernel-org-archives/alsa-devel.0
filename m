From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [FFADO-devel] [PATCH 00/19][RFC v2] ALSA:
 firewire-motu: new driver for MOTU FireWire series
Date: Sun, 29 Jan 2017 23:52:39 +1030
Message-ID: <20170129132239.GB15067@marvin.atrad.com.au>
References: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D421266C89
 for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2017 14:22:43 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170129035417.2095-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 29, 2017 at 12:53:58PM +0900, Takashi Sakamoto wrote:
> However, this module cannot handle 828 correctly to generate sound. The
> reason is not clear yet.

There is something odd about the 828 - I have observed this with FFADO. 
While capture works fine, playback remains resolutely muted.  I have
explored various avenues over the last couple of years but have not yet been
able to identify the cause.  As time allows I continue to work on the task.

Regards
  jonathan
