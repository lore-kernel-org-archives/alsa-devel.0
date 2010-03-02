From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Audio4DJ (snd-usb-caiaq) noise when using DVB usb adapter
Date: Tue, 2 Mar 2010 00:45:04 +0000
Message-ID: <74fd948d1003011645l3b595442qde58b6263b4ce710@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Daniel Mack <daniel@caiaq.de>, linux-media@vger.kernel.org
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

(Please CC me directly as I'm not in both lists).


Regards,
Pedro
