From: "John L. Utz III" <john.utz@dmx.com>
Subject: ac97_channel_mode_info() needs a "0ch" added.
Date: Fri, 22 Aug 2008 15:14:22 -0700
Message-ID: <op.uga6p8hd647oa9@jutz-gnto64>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 8B4DC24398
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Aug 2008 00:14:41 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Developers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

When attempting to leverage existing ALSA AC97 infrastructure, i realized  
that the existing infrastructure does not account for the 'prosumer-y'  
concept of repurposing ALL of the jacks as input, including the speaker.

The vt1618 can use any of it's jacks as mic in or line in. if all of them  
are set to be inputs, then ac97_channel_mode_info() needs to return "Och"  
because there would be no output channels.

that would imply that ac97->channel_mode would equal 0, yes?

tnx for any input you can provide.
