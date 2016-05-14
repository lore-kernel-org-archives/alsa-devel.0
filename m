From: Petr Kulhavy <brain@jikos.cz>
Subject: iMX ASRC
Date: Sat, 14 May 2016 20:01:12 +0200
Message-ID: <e75c225f-ae58-6a5b-dbf2-4b18a2ae6770@jikos.cz>
Reply-To: brain@jikos.cz
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fep25.mx.upcmail.net (fep25.mx.upcmail.net [62.179.121.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F54D2606D2
 for <alsa-devel@alsa-project.org>; Sat, 14 May 2016 20:02:13 +0200 (CEST)
Received: from edge02.upcmail.net ([192.168.13.237]) by viefep25-int.chello.at
 (InterMail vM.8.01.05.18 201-2260-151-151-20140610) with ESMTP
 id <20160514180213.WPHJ1507.viefep25-int.chello.at@edge02.upcmail.net>
 for <alsa-devel@alsa-project.org>; Sat, 14 May 2016 20:02:13 +0200
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

now after the SAI MCLK has been enabled on the iMX6UL in the mainstream 
kernel I'm having difficulties getting the ASRC work.
The default pcm device is the SAI-codec link. That if used does not 
activate the ASRC.
If I use the second pcm device the error message "fsl-sai 202c000.sai: 
isr: Transmit underrun detected" repeats forever.
In /proc/asound only the HiFi-ASRC-FE is present  and not the HiFi-ASRC-BE.

Any idea how to get it working and/or how to debug this?

Thanks!
Petr
