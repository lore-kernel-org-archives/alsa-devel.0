From: Chris Rankin <rankincj@yahoo.com>
Subject: [PATCH] Set CLOEXEC flag for pipes in PulseAudio
	plugins
Date: Mon, 26 Sep 2011 17:09:24 +0100
Message-ID: <4E80A3B4.8050507@yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030304050208070904050408"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm1-vm0.bt.bullet.mail.ird.yahoo.com
	(nm1-vm0.bt.bullet.mail.ird.yahoo.com [212.82.108.94])
	by alsa0.perex.cz (Postfix) with SMTP id 3E8492454A
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 18:09:31 +0200 (CEST)
Received: from volcano.underworld (volcano.underworld [192.168.0.3])
	by wellhouse.underworld (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id
	p8QG9O6u031853
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 17:09:27 +0100
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
--------------030304050208070904050408
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I have noticed that Alsa / PulseAudio are leaking a couple of pipes after a 
fork/exec, and have traced the leak to the following two plugins:

libasound_module_ctl_pulse.so
libasound_module_pcm_pulse.so

This is with Fedora 15. I have attached a patch for the problem.

Cheers,
Chris

--------------030304050208070904050408
Content-Type: text/x-patch;
 name="ALSA-PULSE-CLOEXEC.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ALSA-PULSE-CLOEXEC.diff"

--- alsa-plugins-1.0.24.orig/pulse/pulse.c	2011-01-26 11:05:44.000000000 +0000
+++ alsa-plugins-1.0.24/pulse/pulse.c	2011-09-26 16:49:43.000000000 +0100
@@ -114,6 +114,10 @@
 	return fcntl(fd, F_SETFL, fl | O_NONBLOCK);
 }
 
+static int make_close_on_exec(int fd) {
+    return fcntl(fd, F_SETFD, FD_CLOEXEC);
+}
+
 snd_pulse_t *pulse_new(void)
 {
 	snd_pulse_t *p;
@@ -134,7 +138,9 @@
 	p->thread_fd = fd[1];
 
 	make_nonblock(p->main_fd);
+	make_close_on_exec(p->main_fd);
 	make_nonblock(p->thread_fd);
+	make_close_on_exec(p->thread_fd);
 
 	p->mainloop = pa_threaded_mainloop_new();
 	if (!p->mainloop)

--------------030304050208070904050408
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030304050208070904050408--
