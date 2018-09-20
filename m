From: Jussi Laako <jussi@sonarnerd.net>
Subject: [RFC] ALSA: usb-audio: Add custom mixer status quirks
	for RME CC devices
Date: Fri, 21 Sep 2018 01:07:19 +0300
Message-ID: <1537481240-4999-1-git-send-email-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 05A49267889
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2018 00:07:36 +0200 (CEST)
Received: from porkkala.uworld (porkkala.uworld [IPv6:fc00::2])
 by mail.sonarnerd.net (Postfix) with ESMTP id 809E023111A
 for <alsa-devel@alsa-project.org>; Fri, 21 Sep 2018 01:07:34 +0300 (EEST)
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

This patch accessing vendor specific registers of RME Class Compliant
devices works otherwise fine, but there is still one small problem. It is
supposed to be a polled from the hardware, since the values indicate
device status and are subject to change at all times. Behavior is correct
if I keep running "amixer" all the time to retrieve values - sampling rate
changes are visible and values get updated. However, when I poll the
values from an application without reopening the mixer, they are being
cached somewhere and the changes are not reflected. This problem doesn't
exist for example with PCIe based RME HDSPe AIO and application gets
updated values, but in this USB based device case they don't get updated.
I have flagged all the mixer controls as read-only and volatile, but the
volatile flag is not honored in this (assuming I've understood it correctly).

Any guidance on how to fix the caching problem is welcome!
