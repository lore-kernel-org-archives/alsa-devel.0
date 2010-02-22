From: Felix Homann <fexpop@web.de>
Subject: M-Audio Fast Track Ultra 8R - USB Sniffs and first
	layman's analysis
Date: Mon, 22 Feb 2010 10:34:58 +0100
Message-ID: <4B824FC2.3020101@web.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030407020008090001050807"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wp188.webpack.hosteurope.de (wp188.webpack.hosteurope.de
	[80.237.132.195])
	by alsa0.perex.cz (Postfix) with ESMTP id 2117110382F
	for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2010 10:35:00 +0100 (CET)
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

This is a multi-part message in MIME format.
--------------030407020008090001050807
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

as posted on the alsa-user list, I could get the Fast Track Ultra
8R (USB Id 0763:2881) partially working with Clemes Ladisch's patch for
the Fast Track Ultra (w/o 8R) [1] by just changing the USB Id.

What's not working is setting the sample rate (at least I don't know
how to set it up for 44100 Hz ). And there is no access to the DSP
mixer and effects section.

The nice thing on the DSP mixer is that it remembers it's settings and
operates even without a computer attached. In other words, once set
up, the device can operate as a simple stand alone mixer.

In order to help developing  a driver, I've gathered some information
on how the M-Audio Fast Track Ultra 8R interface is set up in Windows
(using Virtualbox and usbmon).
I'm not familiar with USB programming nor with programming audio devices
or Alsa. But I hope, I can give the relevant parts of the usbmon output
nonetheless.

I've grepped the usbmon logs for "Co", the output below contains only the
lines with "Co" in them. Most of them carry a "Co:1:003:0" while some
of them have "Co:1:006:0". I guess that's because of my replugging the
device as at the time of this writing all output has the 006.


I hope somebody can take this information and put in in a
driver.

You can find further information on this device on
http://www.m-audio.com/products/en_us/FastTrackUltra8R.html.

Some parts of my description might make a little more sense looking at
a screenshot of the Windows settings dialog or the flow schematics,
both of which you can find in the manual, linked to on the site above.

See below my findings. And please, don't hesitate to aks for more
information.

Kind regards,

Felix

[1]
http://www.mail-archive.com/alsa-user@lists.sourceforge.net/msg25385.html


1. Settings on Win**
--------------------

There are 4 regions in the settings tab. (A nice overview on the
Control Panel can be found in the manual, which you can download at
www.m-audio.com.)


1.1 Effect Program
------------------

1.1.1 The Effect Program
------------------------

There are 8 effect programs to choose from a drop down menu: Room 1-3,
Hall 1-2, Plate, Delay and Echo.

Choosing an effect programm yields these relevant parts of the usbmon
output:

     ffff8800a00d0d80 595057804 S Co:1:003:0 s 21 01 0100 0600 0002 2 = 
[VAL]
     ffff8800a00d0d80 595058325 C Co:1:003:0 0 2 >
     ffff8800a00d0d80 595079774 S Co:1:003:0 s 21 01 0200 0600 0001 1 = 40
     ffff8800a00d0d80 595080194 C Co:1:003:0 0 1 >
     ffff8800a00d0d80 595084732 S Co:1:003:0 s 21 01 0300 0600 0002 2 = 0040
     ffff8800a00d0d80 595085070 C Co:1:003:0 0 2 >
     ffff8800a00d0d80 595089766 S Co:1:003:0 s 21 01 0400 0600 0001 1 = 40
     ffff8800a00d0d80 595090192 C Co:1:003:0 0 1 >

where [VAL] is one of the following values:

       0000 for "Room 1"
       0100 for "Room 2"
       0200 for "Room 3"
       0300 for "Hall 1"
       0400 for "Hall 2"
       0500 for "Plate"
       0600 for "Delay"
       0700 for "Echo".

1.1.2 Duration
--------------

There's a control "Duration". Changing it yields these relevant parts of
the usbmon
output:

     ffff8800608fed80 771218819 S Co:1:003:0 s 21 01 0300 0600 0002 2 = 
[VAL]
     ffff8800608fed80 771219174 C Co:1:003:0 0 2 >

where [VAL] seems to range from 0000 (control knob left) to 007f (control
knob right).

1.1.3 Feedback
--------------

There's a control "Feedback", which is only adjustable in the effect
programs "Delay" and "Echo". Changing it yields these relevant parts of
the usbmon
output:

     ffff8800662a6600 3120473733 S Co:1:006:0 s 21 01 0400 0600 0001 1 =
[VAL]
     ffff8800662a6600 3120474160 C Co:1:006:0 0 1 >

where [VAL] seems to range from 00 (control knob left) to 7f (control
knob right).



1.1.4 Volume
------------

There's a control "Volume". Changing it yields these relevant parts of
the usbmon
output:

     ffff8800ac1ed900 2882138576 S Co:1:006:0 s 21 01 0200 0600 0001 1 =
[VAL]
     ffff8800ac1ed900 2882138990 C Co:1:006:0 0 1 >


where [VAL] seems to range from 00 (control knob left) to 7f (control
knob right).


1.2 Sample rate
---------------

1.2.1 Sync Source
-----------------

There's a drop down menu for selecting the sync source. The choices
are "Internal" and "External" (<- SPDIF).

When set to "External" there
are lots of "Zi" lines in the log like these:

     ffff88006638d000 3325892013 C Zi:1:006:1 0:1:904:0 8 0:0:168
0:312:144 0:624:120 0:936:144 0:1248:168 1152 = a7e4fff5 d7ff6fe3
ffb0e0ff a9e9ff65 dcff0000 00000000 cce4fffa d7ff8ee3
     ffff88004e611800 3325893010 C Zi:1:006:1 0:1:912:0 8 0:0:168
     0:312:144 0:624:120 0:936:168 0:1248:144 1176 = d7e5ff0a d9ff6ce4
     ff0be2ff 17eaff66 ddff0000 00000000 eee5ff32 d9ff59e4

Don't know if they are relevant.



1.2.1.1 From "Internal" to "External"
-------------------------------------

Here's what happens when switching the "Sync Source" from "Internal" to
"External":

        ffff8800662a60c0 3325542111 S Co:1:006:0 s 01 0b 0000 0001 0000 0
        ffff8800662a60c0 3325543386 C Co:1:006:0 0 0
        ffff88009159e740 3325594872 S Co:1:006:0 s 01 0b 0000 0002 0000 0
        ffff88009159e740 3325596263 C Co:1:006:0 0 0
        ffff8800a00d0900 3325633405 S Co:1:006:0 s 01 0b 0001 0001 0000 0
        ffff8800a00d0900 3325633637 C Co:1:006:0 0 0
        ffff88009159e440 3325644251 S Co:1:006:0 s 01 0b 0002 0002 0000 0
        ffff88009159e440 3325644631 C Co:1:006:0 0 0
        ffff8800a00d0480 3326127863 S Co:1:006:0 s 22 01 0100 0001 0003 3
= 80bb00
        ffff8800a00d0480 3326128270 C Co:1:006:0 0 3 >
        ffff8800a00d0480 3326132492 S Co:1:006:0 s 22 01 0100 0081 0003 3
= 80bb00
        ffff8800a00d0480 3326132895 C Co:1:006:0 0 3 >

  1.2.1.2 From "External" to "Internal"
-------------------------------------

Here's what happens when switching the "Sync Source" from "External"
to "Internal":

    ffff8800a00d0480 3349133460 S Co:1:006:0 s 01 0b 0000 0001 0000 0
    ffff8800a00d0480 3349134696 C Co:1:006:0 0 0
    ffff88009159e740 3349186489 S Co:1:006:0 s 01 0b 0000 0002 0000 0
    ffff88009159e740 3349187696 C Co:1:006:0 0 0
    ffff88009159e440 3349239544 S Co:1:006:0 s 01 0b 0001 0001 0000 0
    ffff88009159e440 3349239823 C Co:1:006:0 0 0
    ffff8800a00d0900 3349255385 S Co:1:006:0 s 01 0b 0001 0002 0000 0
    ffff8800a00d0900 3349256567 C Co:1:006:0 0 0

1.2.2 Sample Rate
-----------------

When "Sync Source" is set to "Internal" you can choose a sample rate
44.1 kHz, 48 kHz, 88.2 kHz an 96 kHz.

      ffff88007a826a40 4164558574 S Co:1:003:0 s 22 01 0100 0001 0003 3 =
007701
      ffff88007a826a40 4164559977 C Co:1:003:0 0 3 >
      ffff88007a826a40 4164563251 S Co:1:003:0 s 22 01 0100 0081 0003 3 =
007701
      ffff88007a826a40 4164563597 C Co:1:003:0 0 3 >

where [Val] is one of the following values:

       44ac00 for 44.1 kHz
       80bb00 for 48 kHz
       885801 for 88.2 kHz
       007701 for 96 kHz

1.3 Other settings
------------------

The other settings do not seem to change anything on the device but are only
related to the driver or the GUI. (Well, maybe the "High Performance
Mode" button changes something on the device, when the driver is
loaded next time.)


2. The mixer (on Win**)
-----------------------

The Fast Track Ultra 8R features 4 monitor mixers. Monitor 1/2, 3/4,
5/6 and 7/8. They are mixing to the corresponding outputs 1-8. Each
mixer is represented by controls for "Analog In 1-8" and "Software
Return 1-8" and "Master Out 1/2".

For each of those 16 channels ("Analog In"s and "Software Return"s)
there is a level slider, a pan knob, a mute button and a solo button.

"Master Out" 1+2 are represented by a level slider.

For "Monitor 1/2" and "Monitor 3/4" in addition to the controls
mentioned above there's an "Effects Send" control knob for each
"Analog In" and "Software Return", a control knob "Effects Return" for
each of the "Master Out"s and a "Effects Bypass" button.


2.1 Effects Bypass
------------------

2.1.1 Monitor 1/2 Bypass
------------------------

Setting the Monitor 1/2 to bypass the effect yields this:

     ffff8800ac1edcc0 734991273 S Co:1:006:0 s 21 01 0201 0700 0002 2 = 0080
     ffff8800ac1edcc0 734991583 C Co:1:006:0 0 2 >
     ffff8800ac1edcc0 734999254 S Co:1:006:0 s 21 01 0202 0700 0002 2 = 0080
     ffff8800ac1edcc0 734999581 C Co:1:006:0 0 2 >

Reenabling the effects on Monitor 1/2 yields this:

     ffff8800662a63c0 1084925217 S Co:1:006:0 s 21 01 0201 0700 0002 2 = 
e7cd
     ffff8800662a63c0 1084925584 C Co:1:006:0 0 2 >
     ffff8800662a63c0 1084934745 S Co:1:006:0 s 21 01 0202 0700 0002 2 = 
e7cd
     ffff8800662a63c0 1084935078 C Co:1:006:0 0 2 >

2.1.2 Monitor 3/4 Bypass
------------------------

Setting the Monitor 3/4 to bypass the effect yields this:

     ffff8800ac1ed0c0 3024153559 S Co:1:006:0 s 21 01 0203 0700 0002 2 = 
0080
     ffff8800ac1ed0c0 3024153901 C Co:1:006:0 0 2 >
     ffff8800ac1ed0c0 3024158859 S Co:1:006:0 s 21 01 0204 0700 0002 2 = 
0080
     ffff8800ac1ed0c0 3024159277 C Co:1:006:0 0 2 >

Reenabling the effects on Monitor 3/4 yields this:

        ffff8800662a6840 3034928368 S Co:1:006:0 s 21 01 0203 0700 0002 2
= e7cd
        ffff8800662a6840 3034928788 C Co:1:006:0 0 2 >
        ffff8800662a6840 3034936142 S Co:1:006:0 s 21 01 0204 0700 0002 2
= e7cd
        ffff8800662a6840 3034936540 C Co:1:006:0 0 2 >


2.2 Levels
----------

Changing a level for a channel yields this:

      ffff880093800e00 3649051254 S Co:1:003:0 s 21 01 [OutIn] 0500 0002
2 = [VAL]
      ffff880093800e00 3649051527 C Co:1:003:0 0 2 >

where
       [VAL] ranges from 0080 to ffff and

       [OutIn] is a number composed of the Out-channel (01-08) and In
       ranges from 01 to 10 (Hex, Software returns starting at 09).

Example: [OutIn] = 0209 for the Level of "Software Return 1" on Out 2.

2.2.1 Panning
-------------

Panning is done by changing the respective Levels for 2 channels. When
panning is in the middle position, the max value for each level seems
to be "fdfc". Example:

    ffff8800ac1edd80 1908059496 S Co:1:003:0 s 21 01 0402 0500 0002 2 = fdfc
    ffff8800ac1edd80 1908059852 C Co:1:003:0 0 2 >
    ffff8800ac1edd80 1908064495 S Co:1:003:0 s 21 01 0302 0500 0002 2 = fdfc
    ffff8800ac1edd80 1908064850 C Co:1:003:0 0 2 >

This sets the level of "Analog In 2"  in "Monitor 3/4" to the maximum
value while the panning control is in the middle position.

2.3 Solo and Mute
-----------------

Solo and Mute are operated by changing the respective levels to
minimum value. In other words: Not a seperate action from changing
levels.

2.4 Effects Send
----------------

Changing the Effects send value for a Channel


     ffff8800ac1ed840 958480452 S Co:1:[MON]:0 s 21 01 09[CH] 0500 0002 2
= [VAL]
     ffff8800ac1ed840 958480800 C Co:1:[MON]:0 0 2 >

where

     [VAL] ranges from e7cd (knob left, minimum) to daff (knob
     right, maximum),

     [MON] = 003 for Monitor 1/2 and 006 for Monitor 3/4
and
     [CH] is the channel number (0-10, Hex, Software returns
     starting at 09)


2.5 Effects Return
------------------

2.5.1 Monitor 1/2
-----------------

Setting the "Effects Return 1" ('left') Value in Monitor 1/2 yields

     ffff8800608fe9c0 1220780329 S Co:1:003:0 s 21 01 0201 0700 0002 2 =
[VAL]
     ffff8800608fe9c0 1220780648 C Co:1:003:0 0 2 >

with
      [VAL] from e7cd to daff.

For "Effect Return 2" ('right') it's

         ffff880093800080 1281633920 S Co:1:003:0 s 21 01 0202 0700 0002
2 = [VAL]
         ffff880093800080 1281634358 C Co:1:003:0 0 2 >

2.5.2 Monitor 3/4
-----------------

Setting the "Effects Return 1" ('left') Value in Monitor 3/4 yields

     ffff8800ac1ed240 45150924 S Co:1:006:0 s 21 01 0203 0700 0002 2 = [VAL]
     ffff8800ac1ed240 45151245 C Co:1:006:0 0 2 >

with
      [VAL] from e7cd to daff.

For "Effect Return 2" ('right') it's

     ffff8800a00d0480 31181802 S Co:1:006:0 s 21 01 0204 0700 0002 2 = [VAL]
     ffff8800a00d0480 31182181 C Co:1:006:0 0 2 >

2.6 Master Out
--------------

2.6.1 Monitor 1/2
-----------------

Changing the "Master Out 1" ('left') level in Monitor 1/2 gives this

      ffff880093800440 1385027420 S Co:1:003:0 s 21 01 0109 0500 0002 2 =
[VAL]
      ffff880093800440 1385027770 C Co:1:003:0 0 2 >

changing the "Master Out 2" ('right') level in Monitor 1/2 gives this

      ffff8800ac1ede40 1410769402 S Co:1:003:0 s 21 01 020a 0500 0002 2 =
[VAL]
      ffff8800ac1ede40 1410769744 C Co:1:003:0 0 2 >

with [VAL] ranging from e7cd to 0000 (loudest).



2.6.2 Monitor 3/4
-----------------

Changing the "Master Out 1" ('left') level in Monitor 3/4 gives this

     ffff8800662a6540 4152434840 S Co:1:006:0 s 21 01 030b 0500 0002 2 =
[VAL]
     ffff8800662a6540 4152435226 C Co:1:006:0 0 2 >


changing the "Master Out 2" ('right') level in Monitor 3/4 gives this

      ffff88008280ca40 14381909 S Co:1:006:0 s 21 01 040c 0500 0002 2 = 
[VAL]
      ffff88008280ca40 14382274 C Co:1:006:0 0 2 >


with [VAL] ranging from e7cd to 0000 (loudest).



3. Startup
----------

I've attached a log file showing what happens when the device is
attached to Windows. Please note, that this is done under VirtualBox,
so there might be some noise at the beginning of the file.

I hope, there's some information in the log on how the Windows control
panel gathers the current mixer values from the device.



--------------030407020008090001050807
Content-Type: application/x-gzip;
 name="ftu8r-startup-win.log.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="ftu8r-startup-win.log.gz"

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
--------------030407020008090001050807
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030407020008090001050807--
