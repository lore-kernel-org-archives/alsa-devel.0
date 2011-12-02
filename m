From: David Henningsson <david.henningsson@canonical.com>
Subject: hda-jack-retask - a GUI for easy retasking of your HDA
	Intel codecs!
Date: Fri, 02 Dec 2011 14:40:34 +0100
Message-ID: <4ED8D552.6010207@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id A410524442
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 14:40:36 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: General PulseAudio Discussion <pulseaudio-discuss@lists.freedesktop.org>
List-Id: alsa-devel@alsa-project.org

Something fun for friday afternoon? :-)

Over the past few weeks I=92ve been working (from time to time) with =

HDA-Jack-Retask, a small application that makes the kernel interface for =

jack retasking really easy to use.

Although primarily meant for power users, it focuses on simplicity: Just =

select your codec, then select which pins you want to override and what =

you want them to override to: Headphones, Line Out, Mic, Line In, and so =

on. There are buttons for trying it out right away, and for making your =

override the boot-time default. And of course, a button for removing all =

overrides in case things did not go as planned.

Consider it beta quality for now, and it=92s one of those "won=92t work for =

everyone" programs, but that=92s mostly due to hardware and driver =

limitations.

If you're running Ubuntu 11.10:
You can install it by adding ppa:diwic/hda [1] and then installing the =

hda-jack-retask package. Start it by running =93hda-jack-retask=94 in a =

terminal.
Or from the command line:
   sudo add-ppa-repository ppa:diwic/hda
   sudo apt-get update
   sudo apt-get install hda-jack-retask
   hda-jack-retask &


If you're running something else:
  1) download the source tarball [2]
  2) Ensure you have a build environment (gcc, make, sed, etc), gtk3 =

(and glib) development headers, and the "gksu" application all are =

installed. On debian platforms, these packages are known as =

"build-essential", "libgtk-3-dev" and "gksu".
  3) make
  4) ./hda-jack-retask &

Enjoy!

End user blog post is here [3].

-- =

David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic

[1] https://launchpad.net/~diwic/+archive/hda

[2] =

https://launchpad.net/~diwic/+archive/hda/+files/hda-jack-retask_0.20111129=
.tar.gz =



[3] =

http://voices.canonical.com/david.henningsson/2011/11/29/turn-your-mic-jack=
-into-a-headphone-jack/
