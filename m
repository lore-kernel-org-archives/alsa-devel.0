From: Christophe Greisberger <greisberger@zenon-media.com>
Subject: VX222 documentation change
Date: Tue, 24 Jun 2003 14:35:09 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306241435.09691.greisberger@zenon-media.com>
Reply-To: greisberger@zenon-media.com
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

The documentation for the VX222 is incomplete.
I had problems bringing a VX222/v2 to run, but Takashi Iwai & Jaroslav Kysela
gave me the solution. It should be added to the documentation.

Just before "Now insert the modules into the kernel space.", add :
| One of the alsa-tools must be installed to upload the firmware to the
| card, initialize it and create the devices.
| Download, unzip and install the vxloader part of the alsa-tools package:
|
|         tar xjf alsa-tools-x.y.z
|         cd alsa-driver-x.y.z/vxloader
|         ./configure ; make ; make install

Then, just before "Now adjust your soundcards volume levels...", add :
| Now initialize the card:
|         vxloader

Finally, in the section "Setting up modprobe and kmod support", add the
following after "alias sound-service-0-12 snd-pcm-oss" :
|
|         # Upload firmware of all digigram cards
|         post-install snd-vx222 /usr/local/bin/vxloader
|
| Note: If you are using devfs, add the following instead:
|         alias /dev/mixer snd-mixer-oss
|         alias /dev/dsp snd-pcm-oss
|
|         # Upload firmware of card #1
|         post-install snd-vx222 /usr/local/bin/vxloader -c 0


Cheers!

--
Christophe Greisberger



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
