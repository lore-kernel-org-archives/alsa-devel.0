From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Silent speakers after resume on nx6325
Date: Mon, 21 Mar 2011 12:24:28 +0100
Message-ID: <20110321112428.GM28811@ltw.loris.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id DDE102443E
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 12:24:46 +0100 (CET)
Received: from localhost (ltw.loris.tv [127.0.0.1])
	by ltw.loris.tv (Postfix) with ESMTP id 458621AC65D
	for <alsa-devel@alsa-project.org>; Mon, 21 Mar 2011 12:24:33 +0100 (CET)
Received: from ltw.loris.tv ([127.0.0.1])
	by localhost (ltw.loris.tv [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ClhzmrOttxBc for <alsa-devel@alsa-project.org>;
	Mon, 21 Mar 2011 12:24:28 +0100 (CET)
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

Hi!

This isn't new, but for a couple of months now, the nx6325 (builtin
ATIIXP SB400) sometimes disables the internal speakers after
suspend/resume. (the headphones jack works fine)

It's not exactly jack sensing, the jack states are correct.

I then rmmod snd_hda_intel and modprobe it again, the mute-button-LED
shortly flashes and the speakers are back to life.


Is this a common problem that can be solved by adding a quirk?


Cheers

-- 
mail: adi@thur.de  	http://adi.thur.de	PGP/GPG: key via keyserver
