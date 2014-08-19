From: Tomas Matejka <tomas.matejka@tcz.cz>
Subject: ALSA - Channel swap
Date: Tue, 19 Aug 2014 15:37:20 +0200
Message-ID: <53F35310.2040300@tcz.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ms.tcz.cz (ms.tcz.cz [90.182.135.222])
 by alsa0.perex.cz (Postfix) with ESMTP id 8878F261600
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 15:37:20 +0200 (CEST)
Received: from ms.tcz.cz (localhost [127.0.0.1])
 by ms.tcz.cz (Postfix) with ESMTP id 4B81910032D52
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 15:37:20 +0200 (CEST)
Received: from [192.168.1.247] (unknown [192.168.1.247])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested) by ms.tcz.cz (Postfix) with ESMTPSA
 for <alsa-devel@alsa-project.org>; Tue, 19 Aug 2014 15:37:20 +0200 (CEST)
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

Good afternoon,
i have a problem:
I use sound codec CS4202, which I control with AT91SAM9263.
I'm using ALSA sound library.  When i use CAPTURE mode, sometimes it
swaps left and right channel.
I have found this discussions on Internet, where is described similar
problem:

http://pl.it-usenet.org/thread/17996/3593/
http://sinustrom.info/2013/03/21/atmel-soc-ssc-channel-swapping/

I have figured out, that the problem could be in driver or in ALSA
library. Have you any solution ? Did you encountered similar problem ?
