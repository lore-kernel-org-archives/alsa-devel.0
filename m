From: Jaime T <enopatch@gmail.com>
Subject: usx2y: "should not be here with counts=40" then hard
	lockup (linux 4.9.0)
Date: Tue, 5 Dec 2017 10:18:14 +0000
Message-ID: <CAAbCkm+ZD3_0JPuH5DHs0TT+syJ8tfKEo9x-d1Vv8W3SgQrhuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f193.google.com (mail-wr0-f193.google.com
 [209.85.128.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 13485266AE1
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 11:18:15 +0100 (CET)
Received: by mail-wr0-f193.google.com with SMTP id x49so20414099wrb.13
 for <alsa-devel@alsa-project.org>; Tue, 05 Dec 2017 02:18:15 -0800 (PST)
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

Hi all.

I'm running a fresh and cleanly-installed debian stable (stretch) with
my tascam us-122. After several hours of perfect sound, the kernel
(4.9.0-2-686) emits:

Dec  4 22:30:20 piano kernel: [14707.140766] should not be here with counts=40
Dec  4 22:30:24 piano jackd[793]: ALSA: poll time out, polled for 3999073 usecs
Dec  4 22:30:24 piano jackd[793]: JackAudioDriver::ProcessAsync: read
error, stopping...

and my jack server stops working, followed soon after by a hard
lockup. I've run alsa-info.sh and the results are available at
http://www.alsa-project.org/db/?f=e2385306145a37956360def8fe06e8c0f951839d

Should I log a bug at https://bugzilla.kernel.org/ ?

Many thanks, Jaime
