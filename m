From: Hartmut Geissbauer <nwgbh@swissonline.ch>
Subject: Re: [Alsa-user] Automatic module loading and /etc/init.d/alsasound
Date: Sat, 14 Feb 2004 21:21:21 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1076790081.2494.11.camel@chief.local>
References: <402E5C37.4050506@mbant.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <402E5C37.4050506@mbant.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Martin,

Am Sam, den 14.02.2004 schrieb Martin Braun um 18:34:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> (list moderator: I apologize for sending this mail twice to the
> moderator queue).
> 
> hi alsa-users,
> 
> I recently upgraded from 2.4.24 (everything working fine) to 2.6.2, I
> used the version of ALSA provided with the kernel.
> The trouble is, ALSA works BUT only if I insert the modules manually.
> Now this is pretty annoying, as you can imagine.
> How can I get my system to insert the modules automatically?
> 
> Before, /etc/init.d/alsasound started when I booted up and I didn't have
> to do anything at all. Now,
> 
> $ /etc/init.d/alsasound start
> 
> does absolutely nothing at all.
> 
> I found this in dmesg:
> 
> <dmesg>
> request_module: failed /sbin/modprobe -- snd-card-0. error = 256
> PCI: Found IRQ 11 for device 0000:00:0c.0
> request_module: failed /sbin/modprobe -- snd-card-1. error = 25
> </dmesg>
> 
> this is how my section from modules.conf:
> <modules>
> # ALSA portion
> alias char-major-116 snd
> alias snd-card-0 snd-emu10k1
> 
> # module options should go here
> 
> # OSS/Free portion
> alias char-major-14 soundcore
> alias sound-slot-0 snd-card-0
> 
> # card #1
> alias sound-service-0-0 snd-mixer-oss
> alias sound-service-0-1 snd-seq-oss
> alias sound-service-0-3 snd-pcm-oss
> alias sound-service-0-8 snd-seq-oss
> alias sound-service-0-12 snd-pcm-oss
> </modules>
> 

sorry for the question. Do you know, that the new module-init-tools
(former modutils) are using modprobe.conf instead of modules.conf? (for
kernel 2.6.x)

HTH, Hartmut
-- 
Hartmut Geissbauer <nwgbh@swissonline.ch>



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
