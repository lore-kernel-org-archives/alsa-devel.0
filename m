From: "John L. Utz III" <john.utz@dmx.com>
Subject: alsa-lib: pcm_softvol.c: attenuation curve - it seems
 to be too quiet at full volume
Date: Fri, 22 Jun 2007 16:50:06 -0700
Message-ID: <20070622165006.412ed10a@jutz-fc6.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id AA25F243A8
	for <alsa-devel@alsa-project.org>;
	Sat, 23 Jun 2007 01:47:12 +0200 (CEST)
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

Hello All;

I am in release testing with a fix to our product to use 4 channels on
a CMEDIA 8738-MC6 (previously we only used 2 channels on the CMEDIA
and a separate soundcard for the 2 back channels).

The 8738 is a pretty funny old duck of a chip and i am trying to work
around a subset of it's many idiosyncracies. :-)

The most glaring defect is the absence of hard volume on the back
channels *and* that the back channel is louder than the front channel.

Obviously, this is a great candidate for softvol!

Softvol works quite well *except* that the max volume for the rear
channel is now much quieter than it is without softvol. :-(

Is there anything i can do to alter this behavior?

I notice that there is an initial minimal DB in the file:

#define PRESET_MIN_DB		-51.0

is this where everything starts from? if i bump this up, will i get a
higher max volume?

tnx!

johnu
