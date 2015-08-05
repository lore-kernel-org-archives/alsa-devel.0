From: Arthur Borsboom <arthurborsboom@gmail.com>
Subject: Re: [ALC668]: Asus N751JK - mic selection not working
Date: Wed, 5 Aug 2015 23:30:30 +0200
Message-ID: <CALUcmUm2VL+A0kbXbygJb=9cx7WBbNjJAaLju==z+ibB63om_Q@mail.gmail.com>
References: <CAN8cciYavRQVFoacVxJdiH01ezRfKMvJqxO18HFmLqwGkaJyAg@mail.gmail.com>
 <CALUcmU=mPPwZbCnDa+vVFM_+f_+jv6JfYNN2K7qdnN1PQFmPmg@mail.gmail.com>
 <CAN8ccibaxJR3rrXrFr1_pYV8V7KkoaHo1y9yyjFHTp+_sG9sFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f180.google.com (mail-ob0-f180.google.com
 [209.85.214.180])
 by alsa0.perex.cz (Postfix) with ESMTP id B032726041D
 for <alsa-devel@alsa-project.org>; Wed,  5 Aug 2015 23:30:50 +0200 (CEST)
Received: by obnw1 with SMTP id w1so41667884obn.3
 for <alsa-devel@alsa-project.org>; Wed, 05 Aug 2015 14:30:49 -0700 (PDT)
In-Reply-To: <CAN8ccibaxJR3rrXrFr1_pYV8V7KkoaHo1y9yyjFHTp+_sG9sFg@mail.gmail.com>
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
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, kailang@realtek.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

I have applied the patch against the mainline kernel 4.2.0-rc5.
I have created the file /etc/modprobe.d/alsa-base.conf and added this line
and rebooted.

options snd_hda_intel model=,asus-headset

Works
---------
Subwoofer
Plugging and unplugging 3,5mm jack: PA switches from speakers to headphones
and from internal microphone to headset microphone.
Playing music on speakers
Playing music on headset

Does not work
-------------------
Microphone: My voice by the headset is not getting to PA.
When playing music the VU meters of the Headphones (= good) and the
Microphone (= not good) in PA show both the music playing.
