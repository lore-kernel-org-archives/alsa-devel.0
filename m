From: =?utf-8?q?Diego=20E=2E=20=27Flameeyes=27=20Petten=C3=B2?=
	<flameeyes@gmail.com>
Subject: ICE1712 softdevices fixes
Date: Tue, 20 Jan 2009 13:29:03 +0100
Message-ID: <1232454545-14043-1-git-send-email-flameeyes@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id A363F2433E
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 13:27:45 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so1554861fgg.44
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 04:27:45 -0800 (PST)
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

The following patches fixes the default device as they appear for
ICE1712-based cards. Without this cards, 'aplay -L' will show a series
of devices like surround40 and surround71 that are not meaningful for
this card, and a front device that would not work.
