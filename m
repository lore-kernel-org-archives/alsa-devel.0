From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Audio4DJ (snd-usb-caiaq) noise when using DVB usb adap
Date: Tue, 2 Mar 2010 01:50:21 +0000
Message-ID: <74fd948d1003011750u1c8293buc12591b1a222ae84@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.149])
	by alsa0.perex.cz (Postfix) with ESMTP id 5620F103811
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 02:50:22 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 26so93851eyw.0
	for <alsa-devel@alsa-project.org>; Mon, 01 Mar 2010 17:50:21 -0800 (PST)
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

Hi all,

I'm encountering a problem with the Audio4DJ audio card with a  DVB
USB adapter (Win-TV NOVA-T USB2 STICK).

The problem is strange because it only happens after I disconnect and
reconnect the audio card.

Procedure 1:
- boot from fresh
- plug the DVB adapter
- plug the Audio4DJ

Everything works correctly - meaning I can watch TV and my audio is fine.

Procedure 2:
- boot from fresh
- plug the Audio4DJ
- plug the DVB adapter

The audio starts cracking every few seconds, and constantly if I use jackd.

Procedure 3:
- boot from fresh
- plug the DVB adapter
- plug the Audio4DJ
(everything is correct, as above in Procedure 1)
- unplug the Audio4DJ
- plug it again

Cracking audio. I'm insisting in "boot from fresh" because from now on
(that is, from the moment that I unplug the Audio4DJ) I always get
cracking audio.

rmmod'ing the snd-usb-caiaq and the usb-dvb modules produces the same
result. I have to boot from fresh and do Procedure 1 for it to work
OK.


Can anyone please give a hint on how to debug this?


Regards,
Pedro
