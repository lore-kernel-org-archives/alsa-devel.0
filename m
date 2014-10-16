From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [RFC PATCH 1/2] ALSA: hda - Fix "PCM" name being
 used on one DAC when there are two DACs
Date: Thu, 16 Oct 2014 17:10:22 +0200
Message-ID: <543FDFDE.7040800@canonical.com>
References: <1413466426-2672-1-git-send-email-david.henningsson@canonical.com>
 <CAN8cciZAteQAaG9GAxwLWyF6u5xH_fGtRDOTq5j+4LNoj_d_jA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 73E5B264FFB
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 17:10:23 +0200 (CEST)
In-Reply-To: <CAN8cciZAteQAaG9GAxwLWyF6u5xH_fGtRDOTq5j+4LNoj_d_jA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 2014-10-16 17:02, Raymond Yau wrote:
>
>
> >
> > In the scenario where there is one "Line Out", one "Speaker" and one
> > "Headphone", and there are only two DACs, two outputs will share a DAC.
> > Currently any mixer on such a DAC will get the "PCM" name, which is
> > misleading. Instead use "Headphone+LO" or "Speaker+LO" to better
> > specify what the volume actually controls.
>
> Are there any examples ?
>

I used "hda-emu 
codecs/canonical/alc3226-dell-precision-m2800-ccert-201404-14986 -i 1" 
when developing the patches.

I don't have any hardware available myself that exposes this behavior, 
but I can maybe fake one with hdajackretask, if that counts...

// David
