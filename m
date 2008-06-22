From: "Martin Horn" <martin.horn@ostec.org>
Subject: RME HDSP + Multiface
Date: Sun, 22 Jun 2008 19:45:58 +0200
Message-ID: <a41657e10806221045j491295d6s31ea9d94194ce53a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.242])
	by alsa0.perex.cz (Postfix) with ESMTP id 63BBE247D4
	for <alsa-devel@alsa-project.org>;
	Sun, 22 Jun 2008 19:46:00 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so6504597rvb.32
	for <alsa-devel@alsa-project.org>; Sun, 22 Jun 2008 10:45:58 -0700 (PDT)
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

Hello everybody,

I want to use a RME Multiface soundcard with PCMCIA Cardbus Card on a Dell
Notebook with Ubuntu.
I installed all alsa drivers and other available tools for the RME card
successfully and if I do:

aplay -D plughw:1 track1.wav

I can hear sound and see playback on PCM channels 1+2 in the hdspmixer,
which is a special softwaremixer for this card.

Now the card has 8 in and 8 output channels, and though I am able to send
the sound from PCM channels 1+2 to all physical outputs via the routing
functionalities of the hdspmixer, I need 6 more PCM channels to play through
all 8 physical channels independently. If I do:

aplay -l              or:                          cat /proc/asound/devices

I get only one digital playback device which is the 2 channels already
working as plughw:1. Where are my other PCM channels??

Thank you for any help!!!
Martin
