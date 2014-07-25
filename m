From: Wladimir <laanwj@gmail.com>
Subject: snd_seq_drain_output returns ENOENT when event filter
	is used
Date: Fri, 25 Jul 2014 13:47:40 +0200
Message-ID: <CA+s+GJDE8QMLYxtfZNMBRzi1rmRvOgaKHQ+bFFUOn35AZu+hsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f179.google.com (mail-ig0-f179.google.com
 [209.85.213.179])
 by alsa0.perex.cz (Postfix) with ESMTP id E95582615EE
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 13:47:41 +0200 (CEST)
Received: by mail-ig0-f179.google.com with SMTP id h18so626839igc.12
 for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2014 04:47:40 -0700 (PDT)
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

Hello,

I noticed that writing ALSA sequencer events sometimes fails. When I
debugged further, the cause seems to be that the receiving side (Yoshi
softsynth) has set an event filter using
snd_seq_client_info_event_filter_add, and the sending application
sends events that are filtered out.

>From ptrace:
write(3, "\10\0\0\375\0\0\0\0\0\0\0\0\0\0\376\375\t)
\0\0\0\0\0\0\0\0\0", 28) = -1 ENOENT (No such file or directory)

I think it is wrong that the sender gets errors in this case. It can
send events all day succesfuly as long as the port is not connected
(meaning they all get dropped), but when you connect it to a filtering
client (and some get dropped), it fails.

Details:
OS: Ubuntu 14.04
Kernel: 3.13.0-30-generic
libasound2 version: 1.0.27.2-3ubuntu7

Wladimir
