From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Master vs. Front/Rear/LFE/... elements
Date: Wed, 6 May 2009 19:58:24 +0200
Message-ID: <20090506175824.GA30355@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id B80681037F2
	for <alsa-devel@alsa-project.org>;
	Wed,  6 May 2009 19:58:29 +0200 (CEST)
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
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Heya!

Some cards expose 'Master' volume sliders. Others expose seperate
(stereo) sliders for 'Front', 'Rear' and so on. I have trouble dealing
with them properly in PulseAudio:

First of all, on some cards 'Master' seems not to have any effect on
the actual analog output, only 'Front' and friends do. Is this a bug
or intended behaviour? Can I assume that 'Master' and 'Front' are
always independant?

Secondly, I have trouble supporting the
'Front'/'Rear'/'Side'/... elements properly, since they split up the
surround channels into seperate elements. Now, this is confusing in
many ways, even for "amixer" which will then show channels such as
"Rear Front Left" and so on, which obviously make no
sense. snd_mixer_selem_has_playback_channel() just returns bogus data
for these cases. Why are those elements seperate anyway? Why aren't
they combined into a single multi-channel event? Looking at the APIs I
get the idea that the problem appears to be that elements can only
control all channels the same are all independantly which doesn't
really match 1:1 on my multichannel sound cards. However, wouldn't it
be possible to use the 'index' value of a selem_id for this? I.e. have
a series of controls by the same name but different indexes which
would then implement snd_mixer_selem_has_playback_channel() correctly?
i.e. foo,0 would do front-left/right, foo,1 would do rear, foo,2 would
do lfe, and so? I have no clue how this implemented internally, so not
sure how feasible this might be.

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
