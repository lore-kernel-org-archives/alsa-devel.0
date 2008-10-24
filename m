From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Only one element for multichannel mixer controls
	please!
Date: Sat, 25 Oct 2008 01:49:33 +0200
Message-ID: <20081024234932.GA17812@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 7B1632432D
	for <alsa-devel@alsa-project.org>;
	Sat, 25 Oct 2008 01:49:51 +0200 (CEST)
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

It seems that quite a few ALSA drivers for multichannel sound cards
export three seperate stereo mixer controls to control front, rear and
center/lfe independantly. That sucks because a client (such as
PulseAudio) cannot make use of this. Instead they should export a
single 6ch mixer control!

The "amixer scontents" output looks very strange for these drivers
since it lists a "Rear" control that as a "Front Left" and a "Front
Right" channel. So, what is it now: front or rear?

Is there any reason for this current driver behaviour? I mean, the
mixer knows channel ids like SND_MIXER_SCHN_REAR_LEFT perfectly
well. Or is it that those devices have some devices joined and this
cannot be expressd with a single boolean "joined" for each
control?

Please enlighten me!

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
