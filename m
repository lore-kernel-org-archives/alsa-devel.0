From: David Champlin <david@indico.com>
Subject: Intel Atom SST and low latency audio
Date: Tue, 30 Jun 2015 09:46:38 -0700
Message-ID: <CADOWzzJoVKNsR1aPOPfC+eu-dUvMBPKytC=WZc_ZfOVkzhTg8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f43.google.com (mail-pa0-f43.google.com
 [209.85.220.43])
 by alsa0.perex.cz (Postfix) with ESMTP id B41AA2604D6
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 18:46:39 +0200 (CEST)
Received: by pabvl15 with SMTP id vl15so8125817pab.1
 for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2015 09:46:38 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: vinod.koul@intel.com
Cc: alsa-devel@alsa-project.org, jarkko.nikula@intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

Hi Vinod,

We're creating a machine driver between the Maxim 98090 codec and Intel
Edison in support of a realtime audio application.

So far, we have both record and playback working successfully.  However,
the latency on playback is higher than we would like.  We've searched the
alsa-devel messages but haven't been able to find a solution.  We wondered
if you might help us identify the best routing through the Atom's DSP for
low-latency?

We noticed that a "low latency" path is referenced in the Merrifield DPCM
controls file (controls_v2_dpcm), but it doesn't appear to be implemented
yet.  What do we need to do to set up the SST to use its low latency
paths?  Would this be similar to configuring a media path (sending the
command MMX_SET_MEDIA_PATH, SST command 119)?

Thanks,
David
