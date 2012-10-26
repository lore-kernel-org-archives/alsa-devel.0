From: Muffinman <news@koster.tk>
Subject: Access dummy mixer control through filesystem
Date: Fri, 26 Oct 2012 17:21:06 +0200
Message-ID: <508AAA62.1010804@koster.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f179.google.com (mail-we0-f179.google.com
 [74.125.82.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E46B26510B
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2012 17:21:10 +0200 (CEST)
Received: by mail-we0-f179.google.com with SMTP id z49so1421323wey.38
 for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2012 08:21:10 -0700 (PDT)
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

Hello all,

I want to write an application that tracks in realtime changes in a
dummy mixer control (though not sure which language yet). I think its
best to try to track those changes through the filesystem. For non-dummy
mixer controls I can access them through:
/proc/asound/cardx/codecxxx/xxxx+regs. However, it seems that this does
not work for this dummy mixer control. Is there some other location I
can find this control?

If this is not possible for this type of control, can someone advise me
on what language to use for this project?

Kind regards, Maarten

ps. I've defined the dummy mixer control in /var/lib/alsa/asound.state
as shown below:

state.DAC	{
	control.12345 {
                iface MIXER
                name 'Fake Playback Volume'
                value 100
                comment {
                        access 'read write user'
                        type INTEGER
                        count 1
                        range '0 - 100'
                }
        }

}
