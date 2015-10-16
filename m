From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH 0/7] ALSA: USB-audio: Support Zoom R16
	playback
Date: Fri, 16 Oct 2015 09:22:01 +0200
Message-ID: <alpine.DEB.2.02.1510160916060.4075@lnxricardw1.se.axis.com>
References: <1444906657-16791-1-git-send-email-ricardw@axis.com>
 <s5h4mhrguy4.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 106CF260668
 for <alsa-devel@alsa-project.org>; Fri, 16 Oct 2015 09:22:03 +0200 (CEST)
In-Reply-To: <s5h4mhrguy4.wl-tiwai@suse.de>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Ricard Wanderlof <ricard2005@butoba.net>
List-Id: alsa-devel@alsa-project.org


On Fri, 16 Oct 2015, Takashi Iwai wrote:

> The changes look OK, the only point to be fixed would be the use of
> __le32 for a variable as kbuild bot suggested.

Ok, however I interpreted the kbuild warning as that the output type of =

cpu_to_le32() is the same as the input type, so the resulting 'unsigned =

int' might not necessarily fit into the target u32 variable. So when the =

input type is an unsigned int, it should be cast to an u32 to be the same =

as the output type.

I looked around in various parts of the kernel code to see how =

cpu_to_le32() was used, and most cases have an u32 as the argument, and =

when not, the argument is simply cast to u32, i.e.

unsigned int length;
u32 packet_length =3D cpu_to_le32((u32)length);

> However, there are way too few description in the changelog.  The =

> patches 1-4 are only code shuffling, so it's OK (though, better to =

> mention more explicitly that there is no functional change).  But =

> patches 5-6 are the core part, and this doesn't contain *why* this is =

> needed.  The irony is that you put so many good texts in the cover =

> letter.

Same problem as with the single usb packet length fix I submitted a few =

days ago then. :-)

> So, please make the changelogs more readable and enjoyable instead of
> the cover letter texts.  The cover letter won't be included in the
> commits, after all.

Ok, I'll rework the changelogs over the next few days and resubmit the =

set.

Thanks!

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
