From: Mathieu Monney <zittix_all@xwaves.net>
Subject: ioctl(arg) - uninitialised byte(s) in alsa lib
Date: Wed, 12 Mar 2008 12:49:44 +0100
Message-ID: <47D7C358.6050401@xwaves.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pimpette.xwaves.net (pimpette.xwaves.net [193.58.255.133])
	by alsa0.perex.cz (Postfix) with ESMTP id C2EB7243E5
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 12:49:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by pimpette.xwaves.net (Postfix) with ESMTP id 807B87AB31
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 12:52:05 +0100 (CET)
Received: from pimpette.xwaves.net ([127.0.0.1])
	by localhost (pimpette.xwaves.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Bpe2mCnPjRDF for <alsa-devel@alsa-project.org>;
	Wed, 12 Mar 2008 12:52:03 +0100 (CET)
Received: from [192.168.0.151] (84-74-74-177.dclient.hispeed.ch [84.74.74.177])
	by pimpette.xwaves.net (Postfix) with ESMTP id 11BAD7AAF7
	for <alsa-devel@alsa-project.org>; Wed, 12 Mar 2008 12:52:03 +0100 (CET)
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

Hi all,

I'm currently working on a small audio stack on top of alsa and I'm 
getting some "Syscall param ioctl(arg) contains uninitialized byte(s)" 
errors when I run my program using valgrind. I don't know if it is a bug 
in my program or in alsa lib. What I'm sure is that my program is 
working even though these errors appear.

The dump:

==14279== Syscall param ioctl(arg) contains uninitialised byte(s)
==14279==    at 0x40007F2: (within /lib/ld-2.6.1.so)
==14279==    by 0x40DE911: snd_pcm_prepare (in /usr/lib/libasound.so.2.0.0)
==14279==    by 0x40F2552: (within /usr/lib/libasound.so.2.0.0)
==14279==    by 0x40DE911: snd_pcm_prepare (in /usr/lib/libasound.so.2.0.0)
==14279==    by 0x40E4F0C: snd_pcm_hw_params (in 
/usr/lib/libasound.so.2.0.0)
==14279==    by 0x80A6599: AlsaConfigureDevice (in 
/home/mathieu/BProject/WiFi-VoIP/pjsip/pjsip_host_x86/pjsip-apps/bin/pjsua-i686-pc-linux-gnu)
==14279==    by 0x80A6DE3: pjmedia_snd_open (in 
/home/mathieu/BProject/WiFi-VoIP/pjsip/pjsip_host_x86/pjsip-apps/bin/pjsua-i686-pc-linux-gnu)
==14279==    by 0x809EC85: start_sound_device (in 
/home/mathieu/BProject/WiFi-VoIP/pjsip/pjsip_host_x86/pjsip-apps/bin/pjsua-i686-pc-linux-gnu)
==14279==    by 0x805EE1E: pjsua_set_snd_dev (in 
/home/mathieu/BProject/WiFi-VoIP/pjsip/pjsip_host_x86/pjsip-apps/bin/pjsua-i686-pc-linux-gnu)
==14279==    by 0x80615AA: pjsua_media_subsys_start (in 
/home/mathieu/BProject/WiFi-VoIP/pjsip/pjsip_host_x86/pjsip-apps/bin/pjsua-i686-pc-linux-gnu)
==14279==    by 0x805AAC5: pjsua_start (in 
/home/mathieu/BProject/WiFi-VoIP/pjsip/pjsip_host_x86/pjsip-apps/bin/pjsua-i686-pc-linux-gnu)
==14279==    by 0x805001B: app_main (in 
/home/mathieu/BProject/WiFi-VoIP/pjsip/pjsip_host_x86/pjsip-apps/bin/pjsua-i686-pc-linux-gnu)
==14279==
==14279== Syscall param ioctl(arg) contains uninitialised byte(s)
==14279==    at 0x40007F2: (within /lib/ld-2.6.1.so)
==14279==    by 0x40DE911: snd_pcm_prepare (in /usr/lib/libasound.so.2.0.0)
==14279==    by 0x40E4F0C: snd_pcm_hw_params (in 
/usr/lib/libasound.so.2.0.0)
==14279==    by 0x411C213: snd_pcm_direct_initialize_slave (in 
/usr/lib/libasound.so.2.0.0)
==14279==    by 0x4115DFB: snd_pcm_dmix_open (in 
/usr/lib/libasound.so.2.0.0)
==14279==    by 0x4116286: _snd_pcm_dmix_open (in 
/usr/lib/libasound.so.2.0.0)
==14279==    by 0x40E4384: (within /usr/lib/libasound.so.2.0.0)
==14279==    by 0x40E4A82: (within /usr/lib/libasound.so.2.0.0)
==14279==    by 0x40E4AF2: snd_pcm_open_slave (in 
/usr/lib/libasound.so.2.0.0)
==14279==    by 0x4100CEF: _snd_pcm_plug_open (in 
/usr/lib/libasound.so.2.0.0)
==14279==    by 0x40E4384: (within /usr/lib/libasound.so.2.0.0)
==14279==    by 0x40E4A82: (within /usr/lib/libasound.so.2.0.0)
==14279==
==14279== Syscall param ioctl(arg) contains uninitialised byte(s)
==14279==    at 0x40007F2: (within /lib/ld-2.6.1.so)
==14279==    by 0x40DE7D1: snd_pcm_start (in /usr/lib/libasound.so.2.0.0)
==14279==    by 0x411C5DF: snd_pcm_direct_initialize_slave (in 
/usr/lib/libasound.so.2.0.0)
==14279==    by 0x4115DFB: snd_pcm_dmix_open (in 
/usr/lib/libasound.so.2.0.0)
==14279==    by 0x4116286: _snd_pcm_dmix_open (in 
/usr/lib/libasound.so.2.0.0)
==14279==    by 0x40E4384: (within /usr/lib/libasound.so.2.0.0)
==14279==    by 0x40E4A82: (within /usr/lib/libasound.so.2.0.0)
==14279==    by 0x40E4AF2: snd_pcm_open_slave (in 
/usr/lib/libasound.so.2.0.0)
==14279==    by 0x4100CEF: _snd_pcm_plug_open (in 
/usr/lib/libasound.so.2.0.0)
==14279==    by 0x40E4384: (within /usr/lib/libasound.so.2.0.0)
==14279==    by 0x40E4A82: (within /usr/lib/libasound.so.2.0.0)
==14279==    by 0x80A6E1B: pjmedia_snd_open (in 
/home/mathieu/BProject/WiFi-VoIP/pjsip/pjsip_host_x86/pjsip-apps/bin/pjsua-i686-pc-linux-gnu)

Thank you,

Mathieu Monney
