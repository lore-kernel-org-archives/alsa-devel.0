From: Carl Canuck <carl.canuck.official@gmail.com>
Subject: Documentation Request
Date: Tue, 3 Sep 2013 20:32:18 -0400
Message-ID: <CAPOzVs4y7qc6PGps+rPzAKUUXJPuJSBowaqc2jnb=vRe9QchNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f195.google.com (mail-ie0-f195.google.com
 [209.85.223.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 507F9265481
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2013 02:32:19 +0200 (CEST)
Received: by mail-ie0-f195.google.com with SMTP id f4so2722643iea.10
 for <alsa-devel@alsa-project.org>; Tue, 03 Sep 2013 17:32:18 -0700 (PDT)
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

Hello,

I've recently begun the work of porting a Windows application to
LInux/ALSA.  I think ALSA and it's drivers are quite good, but the
documentation and example code are terribly lacking, especially for one of
the most important use-cases of all:  the full on digital audio workstation.

I humbly request that a full_duplex_audio_with_midi.c file be added to the
example code with the following parameters:

1.  Full duplex audio, just simply memcpy'ing the input to the output would
suffice
2.  Accepts MIDI input;  it doesn't have to do anything useful with the
data, just printing the event parameters to stdout would suffice.
3.  At run time, the application lists all available audio devices and
allows the user to select the device, then make settings such as buffer
size, sample rate, bit depth and whether to use mmap based on the
capabilities of the chosen device
4.  At run time, allows optionally selecting a MIDI device.
5.  Copious code comments that makes no assumption that the person reading
knows anything about the ALSA API or it's constructs, invocations and
methodologies.

This could either be an interactive CLI application written in C, or even a
full GUI application using Qt or GTK.  This could then be used as a shell
for writing more complex applications, instead of each developer having to
reinvent the wheel by trying to figure out how to combine about 4 or so of
the other example applications into a single app.

/Carl
