From: =?iso-8859-1?q?Dinesh=20Ahuja?= <mdlinux7@yahoo.co.in>
Subject: ALSA and Libao libray error: Error Opening Device
Date: Sat, 4 Sep 2004 07:16:44 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040904061644.19921.qmail@web8510.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I am working with libao audio library and wants to
play a wav file via libao library. I have Avance Logic
4000 sound card and I have build and installed Kernel
2.6.8 on my machine. I am using ALSA Version 1.04
which comes in built with Kernel 2.6.8.
I am able to see "snd_als4000" module loaded in the
Kernel and able to play .wav file with aplay command
and able to manage the volume control via amixer
command.

But when I try to execute the sample code i.e.
ao_example which comes along with libao tarball file.
the source code gives me an error "Error Opening
Device" in the function ao_driver_id. Can anyone
suggest me who to play .wav file using libao library
via ALSA drivers.

I have tried ao_driver_id("alsa09") and
ao_driver_id("alsa10") but both doesn't works. Please
guide me over this issue.


Regards
Dinesh

________________________________________________________________________
Yahoo! India Matrimony: Find your life partner online
Go to: http://yahoo.shaadi.com/india-matrimony


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
