From: "John L. Utz III" <john.utz@dmx.com>
Subject: using 'type softvol' in a card conf file in
 /usr/share/alsa/cards, am i doing this right?
Date: Mon, 4 Jun 2007 15:23:06 -0700
Message-ID: <20070604152306.61bb6a2b@jutz-fc6.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id C4C1E24500
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jun 2007 00:20:34 +0200 (CEST)
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

Hello;

I am working with an CMEDIA 8738-MC6 and i am trying to gain control of
the second DAC by way of softvolume. but i seem to not be succeeding
because my application cant find my 'Rear' control, am i doing this
correctly?

the original /usr/share/alsa/cards/CMI8738-MC6.conf

CMI8738-MC6.pcm.rear.0 {
	@args [ CARD ]
	@args.CARD {
		type string
	}
	type hw
	card $CARD
	device 1
}

i have modified it to look thusly: notice that the type is now softvol
and the original hardware description is encapsulated in slave.pcm

# 2nd DAC
CMI8738-MC6.pcm.rear.0 {
        @args [ CARD ]
        @args.CARD {
                type string
        }
        type softvol
        slave.pcm {
                type hw
                card $CARD
                device 1
        }
        control {
                name "Rear Playback Volume"
                card $CARD
        }
}

Shouldnt i now be able to see 'Rear Playback Volume' in the output of
amixer controls ??

as it stands right now, i can not. what am i doing incorrectly?

tnx!

johnu
