From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001924]: snd_pcm_avail_update occasionally returns one billion frames
Date: Wed, 15 Mar 2006 00:03:00 +0100
Message-ID: <b53126afe633a57db7bf8e20fbc3efae@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9B3D51D3
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2006 00:03:00 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1924> 
======================================================================
Reported By:                jussi_kujala
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1924
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             03-15-2006 00:02 CET
Last Modified:              03-15-2006 00:02 CET
======================================================================
Summary:                    snd_pcm_avail_update occasionally returns one
billion frames
Description: 
Under right circumstances ALSA function snd_pcm_avail_update returns a
wrong
value. More precisely, if buffer underruns are disabled like:
<code>
snd_pcm_sw_params_get_boundary( sw_params, &boundary );
snd_pcm_sw_params_set_stop_threshold( playback_handle, sw_params, boundary
);
</code>
and there are constant underruns then it occasionally happens that the
snd_pcm_avail_update returns the desired value plus the pointer boundary
wrapout
value.

I noticed this when using a game called Stepmania, but it happens with a
simple
program that plays .wav with a small buffer. To show that this is really
happening, I have attached files from /proc/asound/card0/pcm0p/sub0.

If this is a some kind of a feature, it would be desirable to document it
:-)
Well I am not 100% certain if this is a fault in ALSA, but it is my best
guess so I make this bug report here.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-15-06 00:02 jussi_kujala   New Issue                                    
03-15-06 00:02 jussi_kujala   File Added: sub0.tar                         
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
