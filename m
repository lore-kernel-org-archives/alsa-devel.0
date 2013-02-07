From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: channel names
Date: Thu, 07 Feb 2013 22:23:15 +0100
Message-ID: <51141B43.7070108@drcomp.erfurt.thur.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [188.40.101.23])
 by alsa0.perex.cz (Postfix) with ESMTP id E3FCD2652FF
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2013 22:23:16 +0100 (CET)
Received: from localhost (ltw.loris.tv [127.0.0.1])
 by ltw.loris.tv (Postfix) with ESMTP id 6403D62738
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2013 22:23:16 +0100 (CET)
Received: from ltw.loris.tv ([127.0.0.1])
 by localhost (ltw.loris.tv [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id uWgidsqaxcOx for <alsa-devel@alsa-project.org>;
 Thu,  7 Feb 2013 22:23:15 +0100 (CET)
Received: from [IPv6:2001:638:906:2:e269:95ff:fe88:796b]
 (foh.inf-ra.uni-jena.de [IPv6:2001:638:906:2:e269:95ff:fe88:796b])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ltw.loris.tv (Postfix) with ESMTPSA id C566362737
 for <alsa-devel@alsa-project.org>; Thu,  7 Feb 2013 22:23:15 +0100 (CET)
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

Hi!

Am I missing something or doesn't ALSA support channel names?

When dealing with multichannel interfaces, it's pretty inconvenient to
remember whether channel 193 is on MADI 3, AES-EBU or phones.

We can address this on the jackd level, however, since OSX allows audio
drivers to name their channels, I wonder how to do the same with ALSA?


Cheers
