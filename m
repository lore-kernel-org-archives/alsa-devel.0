From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: [FFADO-devel] [RFC][PATCH 00/13] alsa-tools:
 libhinawa for control applications of FireWire devices
Date: Tue, 27 Jan 2015 09:35:46 +1030
Message-ID: <20150126230546.GF6483@marvin.atrad.com.au>
References: <1422185674-16431-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
 by alsa0.perex.cz (Postfix) with ESMTP id E19002604EA
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 00:05:50 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1422185674-16431-1-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi S

On Sun, Jan 25, 2015 at 08:34:21PM +0900, Takashi Sakamoto wrote:
> This is RFC for a new library into alsa-tools.
> 
> ALSA in Linux 3.16 or later extends a support for FireWire sound devices.
> Currently ALSA drivers supports streaming functionality only, while
> most of these devices require software implementation to control its
> internal DSP. The way to achieve this is to transfer byte sequence to
> the unit and wait byte sequence which the unit transfers if required.

By way of clarifying the intent here, this library seems to exist to funnel
arbitary async transactions through the alsa kernel module.  This covers the
case whereby the streaming component (in the kernel) influences the way
these commands are carried out, or when an ARM handler (which by definition
must be a centralised resource) forms an integral part of the data exchange. 
Is this more or less correct?

Regards
  jonathan
