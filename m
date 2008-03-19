From: ChernYue Kwok <chernyue.kwok@gdc-tech.com>
Subject: pulseaudio plugin assertion on missing network link
Date: Wed, 19 Mar 2008 17:38:49 +0800
Message-ID: <200803191738.50015.chernyue.kwok@gdc-tech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from helium.gdc-tech.com (www.gdc-tech.com [203.132.205.66])
	by alsa0.perex.cz (Postfix) with ESMTP id F2763243AF
	for <alsa-devel@alsa-project.org>; Wed, 19 Mar 2008 10:39:03 +0100 (CET)
Content-Disposition: inline
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
Cc: Pranay Kumar <pranay@gdc-tech.com>
List-Id: alsa-devel@alsa-project.org

Hello, 

I am using Alsa with the Pulseaudio plugin on Fedora 8,
with the RPMs listed below:

alsa-utils-1.0.15-1.fc8
alsa-lib-devel-1.0.15-1.fc8
alsa-plugins-pulseaudio-1.0.15-2.fc8
alsa-lib-1.0.15-1.fc8

I am using the default configuration files from the 
alsa-plugins-pulseaudio RPM package.
 
I have configured a static address on my server, this static address is set 
when my server boots.
With my network cable plugged in, running 'amixer' returns the simple mixer 
controls on my server.

However, when I run 'amixer' with my network cable unplugged, there is a long 
pause followed by the error message below:
amixer: ctl_pulse.c:576: server_info_cb: Assertion 'ctl && i' failed
Aborted

Is there any way this assertion can be prevented?
If so, how can I prevent this from happening?

Thanks in advance
-- 
Kwok Chern Yue
