From: Marve <marve@xs4all.nl>
Subject: Dell XPS One 2710 HDA Intel PCH - No S/PDIF Output
Date: Sat, 30 Jul 2016 17:24:18 +0200
Message-ID: <5c7db325-ac1c-c8aa-a0cc-32664c50097a@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lb3-smtp-cloud6.xs4all.net (lb3-smtp-cloud6.xs4all.net
 [194.109.24.31])
 by alsa0.perex.cz (Postfix) with ESMTP id A8EF2265A59
 for <alsa-devel@alsa-project.org>; Sat, 30 Jul 2016 17:24:21 +0200 (CEST)
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

Hi all,

I've been trying stuff myself and got help from someone (debianuser) at
#alsa IRC, but without success! I got the advice to explain the issue in
this mailing list!

I'm running Linux Mint 18 on a all-in-one Dell XPS One 2710. Most stuff
works, except sound.

The former Mint version also sound from the speakers worked out of the
box. Now, I have to switch from the Pulse Audio volume control from 
"Speakers" to "Headphones (unplugged)" every time I start up to get
audio from the internal speakers, which is working well then, annoying,
is probably an issue that belongs in another group and not the reason
I'm writing you! :)

The XPS One 2710 has a S/PDIF Toslink (optical) connection. Back in the
days that Microsoft wasn't trying to shove up Windows 10 to everyone, I
successfully could get output from this connection to my JVC Receiver
from Windows7 of the box.

I find it hard to have it configured under Linux.

Partly, with help from a anonymous debianuser on #alsa IRC I checked
with alsamixer that the S/PDIF was not muted. Also, with the Jack
Retasking for HDA tool, I enforced Pin ID: 0x1e is a SPDIF Out
connection. After this, the Pulse Audio Tools shows several new
interesting Built-in Audio options and I think "Digital Stereo (IEC958)
Outout looks most promising. So I select this one and with Output
Devices I select "Digital Output (S/PDIF). Then, when I play something
on the box, the volume meters actually show that there is something
playing, but I can't hear anything from the JVC receiver! The receiver
supports PCM to DTS, but no sound is coming out of it!

Thanks if you could help me out! I am happy to help you when you need
more information or want we to test something. I had this problem on the
previous Linux Mint LTS version and tried to install a newer kernel and
alsa driver, which didn't work - so I decided to wait for the current LTS.

I made a fresh info:
http://www.alsa-project.org/db/?f=556ae2bdae66341579831231ef2d90ca0d7c8e24

If you need one with other settings, please let me know!

Best wishes,
M.
