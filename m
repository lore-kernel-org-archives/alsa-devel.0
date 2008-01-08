From: rmgls@free.fr
Subject: Re: no input/output analog channels on rme multiface I
Date: Tue, 08 Jan 2008 18:45:17 +0100
Message-ID: <20080108174517.C3ADB3228A5@smtp7-g19.free.fr>
Content-Type: multipart/mixed; boundary="===============8902615721008284435=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp7-g19.free.fr (smtp7-g19.free.fr [212.27.42.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FBF024B4A
	for <alsa-devel@alsa-project.org>; Tue,  8 Jan 2008 18:45:21 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============8902615721008284435==


On Fri, 21 Dec 2007 13:41:42 +0100 Takashi Iwai <tiwai@suse.de> wrote
>> on Sun, 09 Dec 2007 23:39:46 +0100, rmgls@free.fr wrote:
>> Hi all,
>> 
>> the multiface 1, does not work for me.
>> it is recognized as hammerfal DSP, but the amixer shows no analog in/out
>> (there are 8 analog I/O in the box) and of course no volume control for
>> any channel.

> Did you try hdspmixer?

> Takashi

yes i tried it, without success, hdspmixer does not start with an
 (inaccesible) message.

as i mentionned earlier, the firmware is correctly loaded,
and the aslamixer doesn't show any analog I/O.
of course one can't play any analog sound,
and the midi part is not detected:
(is it the same problem?°

Note: the kernel is 22.3, running on debian, with the hg version from 20080107:
drivers, libs, and all.

thanks for your help.

Raoul
rmgls@free.Fr

--===============8902615721008284435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8902615721008284435==--
