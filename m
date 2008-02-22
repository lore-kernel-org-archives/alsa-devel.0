From: "Adrian Stancu" <adrian.stancu.82@gmail.com>
Subject: snd-usb-audio syncronisation problem
Date: Fri, 22 Feb 2008 11:51:16 +0200
Message-ID: <43e8c7320802220151p177d2c73y2c9724a4cb4743ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from el-out-1112.google.com (el-out-1112.google.com [209.85.162.176])
	by alsa0.perex.cz (Postfix) with ESMTP id D40E22459D
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 10:51:17 +0100 (CET)
Received: by el-out-1112.google.com with SMTP id z25so312925ele.8
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 01:51:16 -0800 (PST)
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
List-Id: alsa-devel@alsa-project.org

Hi,

I'm using an E-MU 0404 USB interface with the snd-usb-audio module
from alsa 1.0.16, operating in isochronous asynchronous mode. This
interface was producing very annoying click/pop sounds at regular
intervals during playback. Eventually I discovered that the
syncronisation mechanism telling the driver to send audio data faster
or slower to match the interface's consumption speed does not work as
expected, for some reason.

I did a very dirty hack within the source of this driver, simulating
the interface asking for data to be sent a little bit quicker, and
this almost fixed the problem *for me*. I really wish to debug this
issue further, to find what actually does not work as it should in
this feed-back mechanism. However this was the first time I dealt with
alsa source code, so I do not have much experience. Therefore, I
really need help with debugging this problem and maybe finding an
universal fix.

Thanks in advance,
Adi
