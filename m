From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [BUG] Bad decibel data on C-Media USB sound card
Date: Tue, 30 Sep 2014 16:27:59 +0800
Message-ID: <CAN8cciY7zCUWhQMse3G3F0NTmJpFRtDWtY7hT0ur2jRZer_L8w@mail.gmail.com>
References: <CAPMSj_H2Y4r-iFc5i0hBtfuhZKmRzsT9X37XernRLbc4faQbXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qg0-f52.google.com (mail-qg0-f52.google.com
 [209.85.192.52])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F75D260412
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 10:28:01 +0200 (CEST)
Received: by mail-qg0-f52.google.com with SMTP id z60so3414168qgd.25
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 01:27:59 -0700 (PDT)
In-Reply-To: <CAPMSj_H2Y4r-iFc5i0hBtfuhZKmRzsT9X37XernRLbc4faQbXA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Allen M." <ase1592@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> >Do the automatic gain has any side effect when it normalise the volume?
>
> I am unsure of how to go about testing that, 'alsamixer' does not appear
> to allow me to modify automatic gain.
>

You have to specify card number

It affect your measurent if you are using the mic on your usb audio if the
automatic gain control is switch on

>
> >Do you mean the sound card does not has 7248 steps?
>
> I am not familiar with how to properly check, however dbverify indicates
> 'Element volume range is 0..151 (-28.37..-0.06 dB).'
>
> Instructions for dbmeasure on the wiki indicates the need for a Line In,
> the sound card only provides Line Out and Mic In. Will it automatically
> make use of 'Mic In' if 'Line In' is absent? Or do I even need to use it?
>

Background noise affect the result if you are not using line in and line
out with a loopback cable , this mean you have to minimize the background
noise

>
> >You need to find out the value of c->res
> >As you complain dB range -28.37 to -0.06 are not correct
>
> Quick testing done with dbverify:http://ix.io/eyi
>
>
> >You need to calibrate the dB range
>
> Volume Steps <=3 are mute while volume step 4 is audible,
> based on dbverify testing. This 'seems' to indicate that the
> minimum volume is somewhere between -27.81 dB to -27.63 dB?
>

How many steps need to reduce   amplitude of the recorded sine wave by half
when you play a sine wav through your usb audio and record it back using
audacity?

http://mailman.alsa-project.org/pipermail/alsa-devel/2010-September/032016.html

You many need to change the name of the volume control to headphone
playback volume in alsamixertest

> Additional info logs:
> Output of 'amixer -c2 contents':http://ix.io/eyq
> Alsa info script output:http://ix.io/eyn
