From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [PATCH] ALSA: hda/realtek - Add ALC3234 headset
 mode for Optiplex 9020m
Date: Mon, 18 Apr 2016 13:56:34 +0200
Message-ID: <1460980594.2178.0.camel@hadess.net>
References: <1460970642-18359-1-git-send-email-hadess@hadess.net>
 <s5hinzffe65.wl-tiwai@suse.de> <1460973779.18923.8.camel@hadess.net>
 <s5hega3f9jc.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [217.70.183.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 1776626154C
 for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2016 13:56:38 +0200 (CEST)
In-Reply-To: <s5hega3f9jc.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Kailang Yang <kailang@realtek.com>, David Henningsson <diwic@ubuntu.com>
List-Id: alsa-devel@alsa-project.org

On Mon, 2016-04-18 at 13:20 +0200, Takashi Iwai wrote:
> On Mon, 18 Apr 2016 12:02:59 +0200,
> Bastien Nocera wrote:
> > 
> > 
> > On Mon, 2016-04-18 at 11:40 +0200, Takashi Iwai wrote:
> > > 
> > > On Mon, 18 Apr 2016 11:10:42 +0200,
> > > Bastien Nocera wrote:
> > > > 
> > > > 
> > > > 
> > > > The Optiplex 9020m with Haswell-DT processor needs a quirk for
> > > > the
> > > > headset jack at the front of the machine to be able to use
> > > > microphones.
> > > > 
> > > > A quirk for this model was originally added in 3127899, but
> > > > c77900e
> > > > removed it in favour of a more generic version.
> > > > 
> > > > Unfortunately, pin configurations can changed based on
> > > > firmware/BIOS
> > > > versions, and the generic version doesn't have any effect on
> > > > newer
> > > > versions of the machine/firmware anymore.
> > > > 
> > > > With help from David Henningsson <diwic@ubuntu.com>
> > > > 
> > > > Signed-off-by: Bastien Nocera <hadess@hadess.net>
> > > > Tested-by: Bastien Nocera <hadess@hadess.net>
> > > Applied, thanks.
> > Thanks for the quick response. Can you however fix the typo I made?
> > 
> > "pin configurations can changed"
> > should be
> > "pin configurations can change"
> Sorry, too late, it's been already merged and published.

Yay git :/
