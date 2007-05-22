From: Rossco <r.maclachlan@strath.ac.uk>
Subject: ICE1724 alsa driver
Date: Tue, 22 May 2007 12:07:06 +0000 (UTC)
Message-ID: <loom.20070522T134651-295@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 4A4BA244F9
	for <alsa-devel@alsa-project.org>;
	Tue, 22 May 2007 14:25:04 +0200 (CEST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HqTQE-0000p4-I7
	for alsa-devel@alsa-project.org; Tue, 22 May 2007 14:25:02 +0200
Received: from notrouble.cc.strath.ac.uk ([130.159.248.222])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 22 May 2007 14:25:02 +0200
Received: from r.maclachlan by notrouble.cc.strath.ac.uk with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Tue, 22 May 2007 14:25:02 +0200
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

I hope someone can help me. (tried the user list but no response)

I have a hitpoint 7.1ch Envy24ht-s based card with the usual vt1616 multichannel
codec and the wolfson WM8728. The card is recognised as a chaintech av710 with
the only difference being that the card has spdif in as well as out. It appears
to be physically similar to the maddog entertainer (would be good to know if
this is also recognised as an AV710)

By default 2 channel stereo in played through the "front" channel of the card
through the vt1616 codec and I appear to be able to set spdif out through the
mixer (but dont have another device to test at the moment). I have been able to
change default output to go through the wolfson dac through an asound.state file
posted on the web. I have to admit I do not quite understand what the file has
done as it only appears to have removed some of the controls rather than change
or add anything. Only two devices are detected for the card the vt1616 and
IEC958, neither are shown as having any subdevices, therefore I am unsure how
the asound.state file was able to address the wolfson chip which requires i2s
input rather ac-link. This seems to indicate i2s and ac-link modes of the
envy24ht-s chip are active.

Most AV710 users seem happy enough to be able to route to toslink out and/or the
higher quality wolfson chip, therefore there is little discussion of addressing
the other channels of the card. I really want to be able to address each of the
channels of the card so that I can use the convolution programme Brutefir with
the card to create a multiway crossover for my loudspeakers. Is there anyway I
can define each of the cards outputs so that I can select to send audio to any
one of them? 

I am also keen to get the spdif in working and particularly the syncing to spdif
in of the clock that the ice1724 chip supports.

Can these features be added to the driver? Please advise of any required info, I
have all the datasheets and can trace chip pins also.

Thanks in advance.

Ross
