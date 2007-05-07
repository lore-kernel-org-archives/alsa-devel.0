From: "John L. Utz III" <john.utz@dmx.com>
Subject: FIXME for Rear Channels of CMI8738,
 how do i write a softvol to fix this defect?
Date: Mon, 7 May 2007 14:10:18 -0700
Message-ID: <20070507141018.7deae44f@jutz-fc6.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A392245C0
	for <alsa-devel@alsa-project.org>;
	Mon,  7 May 2007 23:08:38 +0200 (CEST)
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

the CMI8738 allows for 4 channel output by providing a second DAC, but
sadly the hardware has no volume control for said second DAC.

A review of /usr/share/alsa/cards/CMI8738-MC6.conf shows that the
implementor of said file was aware of the need to fix the problem:

# 2nd DAC
# FIXME: we need a volume attenuator for rear channel.
CMI8738-MC6.pcm.rear.0 {
        @args [ CARD ]
        @args.CARD {
                type string
        }
        type hw
        card $CARD
        device 1
}



I'd really like to fix this!

Is it fixable by creating a softvol plugin?

http://www.alsa-project.org/alsa-doc/alsa-lib/pcm_plugins.html#pcm_plugins

if so, can i have a hint? :-)

so, if i have to invoke speaker test with -Dhw:0,1 to get 4 channel
out, what does that tell me about how i need to configure a softvol for
this item?

Or am i missing the point and it's actually the *driver* that needs to
be doctored up to provide a softvol implementation. If so, how?

tnx!

johnu
