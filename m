From: "Christian Gleerup" <cromozon@swn.nu>
Subject: getting the sound to work on my asus m6s00v
Date: Tue, 17 Mar 2015 22:45:21 +0100
Message-ID: <5a713868662bb9ea47f5a30bd1849ce8@swn.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.itoverblik.dk (mail.itoverblik.dk [81.7.162.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 6E697260612
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 22:44:11 +0100 (CET)
Received: from swn.nu
 by mail.itoverblik.dk (mail.itoverblik.dk) with ASMTP id 201503172244115178
 for <alsa-devel@alsa-project.org>; Tue, 17 Mar 2015 22:44:11 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I had some problems getting the sound to work on my asus m6s00v 
(I think that is the model, it is a bit worn so I can't really read it)

the symptoms was
* on the integrated speakers, no sound at all
* on the headphone speakers, sound for a very very short period that faded into nothing.

with help from debianuser on freenode#alsa we managed to get it working.
the option that i had to load the module with is the following:
sudo modprobe snd-hda-intel model=3stack-digout
the status now (perfect)...
* sound on integrated speaker.
* sound in headphones (disables integrated speaker output which is fine)
* mic works, both for direct playback and recording
* when recording it is the 'digital' channel that controls the volume of the recording level, all others

Notice: 
I don't have OSS or pulseaudio installed.

I am thinking it would be really nice if the driver automatically could detect that this option is required.

this is the output from the alsa-info script
http://www.alsa-project.org/db/?f=28b98a3bd1efc6a80dbd5c54b52c4472d8ea5496

let me know if I can do anything to help with this.

Regards.
