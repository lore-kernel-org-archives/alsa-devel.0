From: David Preece <davep@zedkep.com>
Subject: /dev/snd/timer failing on Raspberry Pi
Date: Fri, 3 Jan 2014 09:48:33 +1300
Message-ID: <D41B4D18-86D3-4041-9CC9-08E4DB693CA2@zedkep.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pb0-f54.google.com (mail-pb0-f54.google.com
 [209.85.160.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 0ED772615AE
 for <alsa-devel@alsa-project.org>; Thu,  2 Jan 2014 21:48:36 +0100 (CET)
Received: by mail-pb0-f54.google.com with SMTP id un15so14998210pbc.27
 for <alsa-devel@alsa-project.org>; Thu, 02 Jan 2014 12:48:35 -0800 (PST)
Received: from [10.0.1.15] (108.102.69.111.dynamic.snap.net.nz.
 [111.69.102.108])
 by mx.google.com with ESMTPSA id si6sm118619366pab.19.2014.01.02.12.48.33
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 02 Jan 2014 12:48:34 -0800 (PST)
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

Hi,

As per subject, the dmix plugin is failing on Arch and a Raspberry Pi with a poll blocking around the file descriptor for /dev/snd/timer. Could it be related to the RPi not having a real time clock?

There are copious details on the RPi forums... http://www.raspberrypi.org/forum/viewtopic.php?f=53&t=64936

Thanks,
Dave
