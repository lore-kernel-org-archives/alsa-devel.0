From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH 00/20] ALSA: Drop superfluous PCM
 preallocation error checks
Date: Wed, 6 Feb 2019 16:35:04 +0100
Message-ID: <4dc81943-cc23-35fd-eae8-0cb2406a5860@perex.cz>
References: <20190205194221.25924-1-tiwai@suse.de>
 <697e40c0-d0ea-9e50-277e-bba82945c46b@perex.cz>
 <20190206145057.GA17630@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id D10DB26795C
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 16:35:07 +0100 (CET)
In-Reply-To: <20190206145057.GA17630@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dne 6.2.2019 v 15:50 Mark Brown napsal(a):

>> With all respects, do we really need to split those elementary changes
>> to single patches inside the sound tree? I would really prefer to have
>> this inside one patch or maybe few patches (core/pci/asoc/others). Just
>> my two cents.
> 
> FWIW it does mean that life is easier for people doing backports when
> things are split up as there's less chance that some file that wasn't
> added in the kernel version you were interested in was touched by the
> patch.

It's only minor thing for the backports. The proper import procedure
covers this. I don't like to have separate patches for
single-line/single-file changes and this change set belongs to this.

				Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.
