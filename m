From: "Allen M." <ase1592@gmail.com>
Subject: [BUG] Bad decibel data on C-Media USB sound card
Date: Mon, 29 Sep 2014 17:29:33 -0500
Message-ID: <CAPMSj_H2Y4r-iFc5i0hBtfuhZKmRzsT9X37XernRLbc4faQbXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f51.google.com (mail-yh0-f51.google.com
 [209.85.213.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 7CD1E260682
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 00:29:35 +0200 (CEST)
Received: by mail-yh0-f51.google.com with SMTP id c41so6017922yho.24
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 15:29:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: superquad.vortex2@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:

>Do the automatic gain has any side effect when it normalise the volume?

I am unsure of how to go about testing that, 'alsamixer' does not appear
to allow me to modify automatic gain.


>Do you mean the sound card does not has 7248 steps?

I am not familiar with how to properly check, however dbverify indicates
'Element volume range is 0..151 (-28.37..-0.06 dB).'

Instructions for dbmeasure on the wiki indicates the need for a Line In,
the sound card only provides Line Out and Mic In. Will it automatically
make use of 'Mic In' if 'Line In' is absent? Or do I even need to use it?


>You need to find out the value of c->res
>As you complain dB range -28.37 to -0.06 are not correct

Quick testing done with dbverify: http://ix.io/eyi


>You need to calibrate the dB range

Volume Steps <=3 are mute while volume step 4 is audible,
based on dbverify testing. This 'seems' to indicate that the
minimum volume is somewhere between -27.81 dB to -27.63 dB?

Additional info logs:
Output of 'amixer -c2 contents': http://ix.io/eyq
Alsa info script output: http://ix.io/eyn
