From: Olaf Hering <olaf@aepfle.de>
Subject: Re: hdmi audio on Shuttle XS35GS V3L
Date: Fri, 20 Sep 2013 15:45:54 +0200
Message-ID: <20130920134554.GA27434@aepfle.de>
References: <20130919142333.GA29383@aepfle.de>
 <20130920122546.GA9628@aepfle.de> <523C481F.8050703@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mo-p00-ob.rzone.de (mo-p00-ob.rzone.de [81.169.146.161])
 by alsa0.perex.cz (Postfix) with ESMTP id D454A2656D1
 for <alsa-devel@alsa-project.org>; Fri, 20 Sep 2013 15:45:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <523C481F.8050703@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Sep 20, Clemens Ladisch wrote:

> Olaf Hering wrote:
> > Does anyone happen to know if HDMI audio is supposed to work on the
> > Shuttle XS35GS V3L? I have tried an AOC E2260Pwhu monitor and also a
> > Philips 22PFL3805H/12 TV, both show the picture but no sound is played
> > via HDMI.
> >
> > ==> /proc/asound/card0/eld#1.0 <==
> > monitor_present         0
> > eld_valid               0
> 
> > ==> /proc/asound/card1/eld#0.0 <==
> > monitor_present         0
> > eld_valid               0
> 
> Is this with some monitor present?
> 
> Does "aplay -D plughw:0,3 something.wav" or
> "aplay -D plughw:1,3 something.wav" work?

No audio is played. But aplay triggers this in dmesg:

[ 1755.440152] hda-intel: IRQ timing workaround is activated for card #0. Suggest a bigger bdl_pos_adj.
[ 1807.228455] hda-intel: IRQ timing workaround is activated for card #1. Suggest a bigger bdl_pos_adj.

Olaf
