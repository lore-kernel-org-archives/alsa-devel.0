From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: NVIDIA HDMI: Channel remapping does not work for
	stereo?
Date: Fri, 25 Oct 2013 02:31:56 +0300
Message-ID: <5269ADEC.9060707@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id 62630261A92
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 01:32:00 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Aaron Plattner <aplattner@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi!

I just noticed while testing the ALSA HDMI channel remapping code that
my NVIDIA codec 0x10de0015 does not seem to follow the Audio Sample
Packet (ASP) channel mapping (set by verb F34h as per HDA spec 7.3.3.41)
when playing back stereo audio.

This can be reproduced by e.g.:
$ speaker-test -c2 -Dhdmi:CARD=NVidia,DEV=0 -m FR,FL
The channels are reversed compared to what the printout is (i.e. the
codec plays the streams straight-through instead of swapping channels as
instructed).

E.g. this works expectedly, however:
$ speaker-test -c4 -Dhdmi:CARD=NVidia,DEV=1 -m FR,FL,RR,RL

(note that recent sound git master or for-next is needed for these kind
of remappings to work properly at all)

On Intel HDMI codec 0x80862806 both work.

While stereo right-left swapping is admittedly a rather corner-case
situation, I guess we should probably refuse such chmaps when they are
not supported.

Aaron, do you have any information on whether this affects all NVIDIA
HDMI codecs?

-- 
Anssi Hannula
