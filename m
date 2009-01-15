From: James Ward <jeward@torzo.com>
Subject: Mac Pro problem with USB soundcard
Date: Thu, 15 Jan 2009 09:31:11 -0700 (MST)
Message-ID: <652573086.165321232037071454.JavaMail.root@mail.torzo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.torzo.com (smtp.torzo.com [66.210.5.93])
	by alsa0.perex.cz (Postfix) with ESMTP id C9118103853
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 17:31:13 +0100 (CET)
Received: from mail.torzo.com (mail.torzo.com [66.210.5.94])
	by smtp.torzo.com (Postfix) with ESMTP id 8F7A57B83A8
	for <alsa-devel@alsa-project.org>; Thu, 15 Jan 2009 09:31:11 -0700 (MST)
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

I'm running 64 Bit Sabayon Linux 4.0 r1 on a Mac Pro.  I have connected a Creative USB sound card and would like to use it as the default.

I tried these two .asoundrc files suggested by gnubien on #alsa:

pcm.!default {
    type hw
    card 1
}
ctl.!default {
    type hw           
    card 1
}

and:

created by wishie on #alsa 10-13-07
#Set the card you want to use here.. this example is for hw:1,0

pcm.snd_card {
        type hw
        card 1 
#change "card 1" to the card number listed for your usb soundcard using cat /proc/asound/cards output
        device 0
}

pcm.!default {
        type plug
        slave.pcm "dmixer"
}

pcm.dmixer {
        type dmix
        ipc_key 1024
        ipc_key_add_uid false
        ipc_perm 0660        
        slave {
                pcm "snd_card"
                rate 48000
                period_time 0
                period_size 1024
                buffer_time 0
                buffer_size 5120
        }
}

Either of these .asoundrc files result in the USB soundcard going away.  I have to unplug it and plug it back in to get it back.  Please help.

James

-- 
Ward... James Ward
Linux System Administrator
System Administration
Phone:  520-290-0910 ext 268
Fax:    520-546-3442
ICQ:    201663408
Jabber: james@jabber.chinoc.net
