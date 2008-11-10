From: Romain <romainguinot@gmail.com>
Subject: Backported sbxfi driver (UNTESTED!)
Date: Mon, 10 Nov 2008 01:26:49 +0100
Message-ID: <ae44b51f0811091626r292b1504nca2b30b3b59a981f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 8ABB2103815
	for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2008 01:26:50 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so2130343fgg.44
	for <alsa-devel@alsa-project.org>; Sun, 09 Nov 2008 16:26:49 -0800 (PST)
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

I've tested the sbxfi driver and it works great on my setup.

Had little problems before getting it running :
i had to comment out the snd_printk stuff, otherwise the module wouldn't
load (snd_printk* symbols not found, in dmesg)
This was probably not the cleanest way to deal but  it's just debug messages
and i'm new wrt kernel driver hacking.
I also had to disable my onboard audio in BIOS, otherwise the X-Fi would not
get picked up.

i'm using Fedora 9 with Linux 2.6.26.6-79.fc9.i686 kernel (standard supply
from fedora repos),and pulseaudio
I'm using with standard 2.1 jack output, i do not yet own home cinema
speakers so i couldn't test all the cabling options.

Thanks for this great work,

Best Regards,
Romain.
