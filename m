From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001924]: snd_pcm_avail_update occasionally returns one billion frames
Date: Tue, 4 Apr 2006 20:40:03 +0200
Message-ID: <7fc8f45292495b123ba75875c59a85e2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B9763221
	for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2006 20:40:03 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1924> 
======================================================================
Reported By:                jussi_kujala
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1924
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-15-2006 00:02 CET
Last Modified:              04-04-2006 20:40 CEST
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

----------------------------------------------------------------------
 jussi_kujala - 04-04-06 20:25 
----------------------------------------------------------------------
yes, with rc3 too

----------------------------------------------------------------------
 tiwai - 04-04-06 20:40 
----------------------------------------------------------------------
If I understand your description correctly, this must be a feature.
snd_pcm_avail_update() returns the value between 0 and boundary.  If the
DMA position overcomes the applptr (i.e. xrun), it result in a negative
value, but snd_pcm_avail_update() corrects to a positive value by adding
the boundary.

So, if the return value of snd_pcm_avail_update() is bigger than the
buffer size, it means that something is wrong, but the system continues
because you disabled XRUN detection by setting stop_threshold to
boundary.

Yes, this should be better explained in the document...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-15-06 00:02 jussi_kujala   New Issue                                    
03-15-06 00:02 jussi_kujala   File Added: sub0.tar                         
03-15-06 11:44 tiwai          Note Added: 0008532                          
04-04-06 20:25 jussi_kujala   Note Added: 0009115                          
04-04-06 20:40 tiwai          Status                   new => resolved     
04-04-06 20:40 tiwai          Resolution               open => not an issue
04-04-06 20:40 tiwai          Assigned To               => tiwai           
04-04-06 20:40 tiwai          Note Added: 0009116                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
