From: "Azhar Aga" <azhar.aga@gmail.com>
Subject: Multiple Stream Playback on HDA-Intel
Date: Sun, 9 Sep 2007 05:47:15 -0800
Message-ID: <de9037e0709090647x53d4a83eqd0c2c2e2be59b136@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.185])
	by alsa0.perex.cz (Postfix) with ESMTP id 07531103933
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Sep 2007 15:47:16 +0200 (CEST)
Received: by rv-out-0910.google.com with SMTP id k20so767157rvb
	for <alsa-devel@alsa-project.org>; Sun, 09 Sep 2007 06:47:15 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,
   I am trying ao develop an application that would play multiple streams,
using the same soundcard on my PC and since this is my first stint in
developing application on a pc rather than a native board I am facing
problems, for doing this I am using libao to control ALSA.  For me to
demostrate the multiple stream playback, I need ALSA to direct output of one
of the streams on the device hw:0,0 and the other on hw:0,1 [My card has
probably two devices as I checked aplay -l option that gave me a list of
devices] so that i could  connect a set of speakers in one of the PC jacks
and the another set in another Jack. Can this be done in using libao. If not
then how one direct the sound output to other devices on the same card.
Does the configuation file need to be changed? I made a .asoundrc config
file in the the root directory but  that did not help when I tried to access
a hw:0,0 with the command aplay -D hw:0,0 < some_test_file.wav> it gives me
the device busy error. ( with or without the .asoundrc aplay -d hw:0,0 gives
the above mentioned error)
The Card I am using is HDA_intel ICH family that comes with the DELL.

-- 
Thanks and With Regards
Azhar Aga
