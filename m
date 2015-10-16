From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH 0/7] ALSA: USB-audio: Support Zoom R16
	playback
Date: Fri, 16 Oct 2015 13:20:22 +0200
Message-ID: <alpine.DEB.2.02.1510161318490.4075@lnxricardw1.se.axis.com>
References: <1444906657-16791-1-git-send-email-ricardw@axis.com>
 <s5h4mhrguy4.wl-tiwai@suse.de>
 <alpine.DEB.2.02.1510160916060.4075@lnxricardw1.se.axis.com>
 <s5h8u73jf31.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bes.se.axis.com (bes.se.axis.com [195.60.68.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B5EF260671
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 13:20:24 +0200 (CEST)
In-Reply-To: <s5h8u73jf31.wl-tiwai@suse.de>
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
Cc: =?ISO-8859-15?Q?Ricard_Wanderl=F6f?= <ricardw@axis.com>, Ricard Wanderlof <ricard2005@butoba.net>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


On Fri, 16 Oct 2015, Takashi Iwai wrote:

> > unsigned int length;
> > u32 packet_length =3D cpu_to_le32((u32)length);
> =

> No, other way round: the problem is that packet_length is declared as
> u32 while it should be __le32.  The length variable must be CPU
> endian, of course, as you apply C arithmetic.

So the cast shouldn't be necessary then, i.e. just simply:

unsigned int length;
__le32 packet_length =3D cpu_to_le32(length);

?

It makes sense to me (although that doesn't necessarily make it right. :-) )

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
