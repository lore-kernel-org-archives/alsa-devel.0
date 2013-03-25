From: Torstein Hegge <hegge@resisty.net>
Subject: Re: [Alsa-user]  Audio-gd NFB-17.32 (VIA VT1731)
Date: Mon, 25 Mar 2013 10:48:41 +0100
Message-ID: <20130325094841.GB18838@pvv.ntnu.no>
References: <20130322215650.GF7539@pvv.ntnu.no>
 <514DD773.8060408@guest.arnes.si> <514E3778.1050801@guest.arnes.si>
 <20130324205326.GB776@pvv.ntnu.no>
 <514FFEE8.4070300@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from microbel.pvv.ntnu.no (microbel.pvv.ntnu.no [129.241.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 935E7261694
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2013 10:48:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <514FFEE8.4070300@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@googlemail.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 25, 2013 at 08:38:16 +0100, Clemens Ladisch wrote:
> Torstein Hegge wrote:
> > I think we can conclude that the VIA VT1731 has the same issue as the
> > C-Media CM6631.
> >
> > I'll add the VT1731 as one of the devices that needs a reset after
> > sample rate change in the next iteration of the sample rate workaround
> > patch.
> 
> Why not just do it for all UAC 2 devices?

If new devices that needs this just keeps popping up, that might indeed
be the better solution.


Torstein
