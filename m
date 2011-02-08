From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2] ALSA: add LaCie Firewire
 Speakers/Griffin FireWave surround driver
Date: Tue, 08 Feb 2011 14:37:00 +0100
Message-ID: <4D5146FC.7050708@ladisch.de>
References: <4D46933D.5050609@ladisch.de>	<4D4FB7C8.7090501@ladisch.de>	<4D4FB7F6.8000801@ladisch.de>	<20110207154025.13fdeba3@stein>
	<20110207225604.3fe43920@stein>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050802020209070507020707"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id DB37C103813
	for <alsa-devel@alsa-project.org>; Tue,  8 Feb 2011 14:36:00 +0100 (CET)
In-Reply-To: <20110207225604.3fe43920@stein>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, Jay Fenlason <fenlason@redhat.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050802020209070507020707
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Stefan Richter wrote:
> Xine, although configured to the alsa backend, somehow refuses to use the
> alsa backend and falls through to jack which doesn't have any devices
> present at the moment.  Kaffeine which uses xine as backend pops up a
> window that it can't open the sound device.

Unfortunately, xine doesn't have useful error messages ...

Try "aplay -D plughw:FireWave something.wav" (or -D plughw:Speakers).

> KDE4's hardware control, sound pane, shows the card and lets me play the
> test sound on it.  First few seconds are choppy. [...]
> 
> Next test:  Plugged the Speakers in, unloaded snd_hda_intel, loaded
> firewire-ohci, snd_firewire_speakers now gets bound to devie right away.
> Started xine and played a file.  No complaint.  (Hmm, I wonder whether I
> had an operator error in my earlier session with FireWave.)  There is the
> same problem as in the first KDE4 control panel test:  Playback starts
> with an Autechre remix during the first few seconds. ;-)

If it is the same with both devices, the problem is probably not a wrong
number of channels.

Choppy sound could indicate a wrong sample rate.  Jay used speaker-test,
which uses 48 kHz by default, but most music files are 44.1 kHz, so it
looks as if switching the sample rate does not work correctly.

> Alas the missing mixer makes the whole affair not quite usable yet:  The
> LaCie FireWire Speakers are very loud; too loud for the desk or living
> room.  On OS X, I had their volume pulled down to the lowest mark.

Attached are .conf files that enable software volume emulation for
devices "default", "front", "surround40", and "surround51", but not "hw".
Put them into /usr/share/alsa/cards/ (or wherever your distribution puts
them).


Regards,
Clemens

--------------050802020209070507020707
Content-Type: text/plain;
 name="FWSpeakers.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="FWSpeakers.conf"

IwojIENvbmZpZ3VyYXRpb24gZm9yIHRoZSBMYUNpZSBGaXJld2lyZSBzcGVha2VycwojCgpG
V1NwZWFrZXJzLnBjbS5kZWZhdWx0IHsKCUBhcmdzIFsgQ0FSRCBdCglAYXJncy5DQVJEIHsK
CQl0eXBlIHN0cmluZwoJfQoJdHlwZSBwbHVnCglzbGF2ZS5wY20gewoJCXR5cGUgc29mdHZv
bAoJCXNsYXZlLnBjbSB7CgkJCUBmdW5jIGNvbmNhdAoJCQlzdHJpbmdzIFsgImRtaXg6IiAk
Q0FSRCAiLEZPUk1BVD1TMzIiIF0KCQl9CgkJY29udHJvbCB7CgkJCW5hbWUgIlBDTSBQbGF5
YmFjayBWb2x1bWUiCgkJCWNhcmQgJENBUkQKCQl9Cgl9Cn0KCjxjb25mZGlyOnBjbS9mcm9u
dC5jb25mPgoKRldTcGVha2Vycy5wY20uZnJvbnQuMCB7CglAYXJncyBbIENBUkQgXQoJQGFy
Z3MuQ0FSRCB7CgkJdHlwZSBzdHJpbmcKCX0KCXR5cGUgc29mdHZvbAoJc2xhdmUucGNtIHsK
CQl0eXBlIGh3CgkJY2FyZCAkQ0FSRAoJfQoJY29udHJvbCB7CgkJbmFtZSAiUENNIFBsYXli
YWNrIFZvbHVtZSIKCQljYXJkICRDQVJECgl9Cn0K
--------------050802020209070507020707
Content-Type: text/plain;
 name="FireWave.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="FireWave.conf"

IwojIENvbmZpZ3VyYXRpb24gZm9yIHRoZSBHcmlmZmluIEZpcmVXYXZlIFN1cnJvdW5kCiMK
CkZpcmVXYXZlLnBjbS5kZWZhdWx0IHsKCUBhcmdzIFsgQ0FSRCBdCglAYXJncy5DQVJEIHsK
CQl0eXBlIHN0cmluZwoJfQoJdHlwZSBwbHVnCglzbGF2ZS5wY20gewoJCXR5cGUgc29mdHZv
bAoJCXNsYXZlLnBjbSB7CgkJCUBmdW5jIGNvbmNhdAoJCQlzdHJpbmdzIFsgImRtaXg6IiAk
Q0FSRCAiLEZPUk1BVD1TMzIiIF0KCQl9CgkJY29udHJvbCB7CgkJCW5hbWUgIlBDTSBQbGF5
YmFjayBWb2x1bWUiCgkJCWNhcmQgJENBUkQKCQl9Cgl9Cn0KCjxjb25mZGlyOnBjbS9mcm9u
dC5jb25mPgoKRmlyZVdhdmUucGNtLmZyb250LjAgewoJQGFyZ3MgWyBDQVJEIF0KCUBhcmdz
LkNBUkQgewoJCXR5cGUgc3RyaW5nCgl9Cgl0eXBlIHNvZnR2b2wKCXNsYXZlLnBjbSB7CgkJ
dHlwZSBodwoJCWNhcmQgJENBUkQKCX0KCWNvbnRyb2wgewoJCW5hbWUgIlBDTSBQbGF5YmFj
ayBWb2x1bWUiCgkJY2FyZCAkQ0FSRAoJfQp9Cgo8Y29uZmRpcjpwY20vc3Vycm91bmQ0MC5j
b25mPgoKRmlyZVdhdmUucGNtLnN1cnJvdW5kNDAuMCB7CglAYXJncyBbIENBUkQgXQoJQGFy
Z3MuQ0FSRCB7CgkJdHlwZSBzdHJpbmcKCX0KCXR5cGUgc29mdHZvbAoJc2xhdmUucGNtIHsK
CQl0eXBlIGh3CgkJY2FyZCAkQ0FSRAoJfQoJY29udHJvbCB7CgkJbmFtZSAiUENNIFBsYXli
YWNrIFZvbHVtZSIKCQljYXJkICRDQVJECgl9Cn0KCjxjb25mZGlyOnBjbS9zdXJyb3VuZDQx
LmNvbmY+Cjxjb25mZGlyOnBjbS9zdXJyb3VuZDUwLmNvbmY+Cjxjb25mZGlyOnBjbS9zdXJy
b3VuZDUxLmNvbmY+CgpGaXJlV2F2ZS5wY20uc3Vycm91bmQ1MS4wIHsKCUBhcmdzIFsgQ0FS
RCBdCglAYXJncy5DQVJEIHsKCQl0eXBlIHN0cmluZwoJfQoJdHlwZSByb3V0ZQoJdHRhYmxl
IFsKCQlbIDEgMCAwIDAgMCAwIF0KCQlbIDAgMSAwIDAgMCAwIF0KCQlbIDAgMCAwIDAgMSAw
IF0KCQlbIDAgMCAwIDAgMCAxIF0KCQlbIDAgMCAxIDAgMCAwIF0KCQlbIDAgMCAwIDEgMCAw
IF0KCV0KCXNsYXZlLnBjbSB7CgkJdHlwZSBzb2Z0dm9sCgkJc2xhdmUucGNtIHsKCQkJdHlw
ZSBodwoJCQljYXJkICRDQVJECgkJfQoJCWNvbnRyb2wgewoJCQluYW1lICJQQ00gUGxheWJh
Y2sgVm9sdW1lIgoJCQljYXJkICRDQVJECgkJfQoJfQp9Cg==
--------------050802020209070507020707
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------050802020209070507020707--
