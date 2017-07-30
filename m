From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Basic questions
Date: Sun, 30 Jul 2017 16:24:29 +0200
Message-ID: <4b177673-e96e-a7b9-7597-092b637ac52f@ladisch.de>
References: <97e15f1e-2bd6-9eb8-45a8-4cfbd862ede9@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A70D9266C9B
 for <alsa-devel@alsa-project.org>; Sun, 30 Jul 2017 16:24:49 +0200 (CEST)
In-Reply-To: <97e15f1e-2bd6-9eb8-45a8-4cfbd862ede9@t-online.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tsepp2001@t-online.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

tsepp2001@t-online.de wrote:
> Am I right to use async mode

No.  It is not supported by all devices, and almost impossible to use
correctly.

> to get lowest latency times

Latency depends on the buffer size, and how fast your code can react to
the notification that some space is available.

> and using pause/play/stop?

You probably want to use non-blocking mode.


Regards,
Clemens
