From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Takashi: please help (compiling alsa-driver)
Date: Wed, 13 Feb 2013 08:31:38 +0800
Message-ID: <CAN8cciZZb-JRP=ssavKH+L4aeSAmZ7_8aQCO+GMWF-uTyYRqFQ@mail.gmail.com>
References: <511ABB0D.90808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f173.google.com (mail-ia0-f173.google.com
 [209.85.210.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 14A4E264F3D
 for <alsa-devel@alsa-project.org>; Wed, 13 Feb 2013 01:31:41 +0100 (CET)
Received: by mail-ia0-f173.google.com with SMTP id h37so652780iak.32
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2013 16:31:38 -0800 (PST)
In-Reply-To: <511ABB0D.90808@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jonas Petersen <jnsptrsn1@gmail.com>
Cc: tiwai@suse.de, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>
> I'm talking to you directly because this
>
>
ftp://ftp.suse.com/pub/people/tiwai/snapshot/alsa-driver-unstable-snapshot.tar.gz
>
> is the only alsa-driver source that I'm able to compile so far. I can
unpack this and simply run ./configure && make && make install. It works
great. (I compile against the kernel-headers from ubuntu).

But there are warning message for four sound card modules  when build in
Ubuntu 12.04 LTS

Section mismatch in reference from the function snd_bt87x_detect_card() to
the variable .devinit.rodata:snd_bt87x_ids
The function snd_bt87x_detect_card() references
the variable __devinitconst snd_bt87x_ids.
This is often because snd_bt87x_detect_card lacks a __devinitconst
annotation or the annotation of snd_bt87x_ids is wrong.

Section mismatch in reference from the function generic_oxygen_probe() to
the variable .devinit.rodata:oxygen_ids
The function generic_oxygen_probe() references
the variable __devinitconst oxygen_ids.
This is often because generic_oxygen_probe lacks a __devinitconst
annotation or the annotation of oxygen_ids is wrong.

Section mismatch in reference from the function xonar_probe() to the
variable .devinit.rodata:xonar_ids
The function xonar_probe() references
the variable __devinitconst xonar_ids.
This is often because xonar_probe lacks a __devinitconst
annotation or the annotation of xonar_ids is wrong.

Do the latest version of alsa-lib require any specific parameter to install
on Ubuntu 12.04 for testing the channel map ?

alsa-lib/test/chmap -D hw:0 query

ALSA lib conf.c:3314:(snd_config_hooks_call) Cannot open shared library
libasound_module_conf_pulse.so
ALSA lib pcm.c:2223:(snd_pcm_open_noupdate) Unknown PCM hw:0
Cannot open PCM stream hw:1 for PLAYBACK

>
> I spent hours in trying to compile from several other sources.
>

What is the proper way to build from git since alsa-driver-build.git only
contain README

The snapshot in alsa-project.org is also unusable
