From: Marcus Andersson <054185595@telia.com>
Subject: Re: ALSA Hammerfall DSP driver
Date: Sun, 26 May 2002 15:42:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CF0E634.33AB0CF3@telia.com>
References: <200205261203.g4QC32328992@mailf.telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailb.telia.com (mailb.telia.com [194.22.194.6])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id PAA04406
	for <alsa-devel@alsa-project.org>; Sun, 26 May 2002 15:37:22 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
> 
> ># alsactl store 1
> >alsactl: get_control:359: Unknown control type: 6
> 
> have you updated your alsa-utils and alsa-lib? there was a new control
> type (64 bit integer) introduced for the H-DSP.

I removed everything alsa from my machine and reinstalled it. This error
is now gone.

> 
> >At some point the 'MIDI STATE out' is lit and stays lit. I don't use
> >MIDI. (I think, if not aplay tries to play a wav as midi.)
> 
> Do you have any idea at what point this happens?

When I load a session in Ardour.

The first time I start alsa, I get errors from both aplay and jackd.

creating alsa driver ... hdsp|1024|2|44100|swmon
ALSA: no playback configurations available
ALSA: cannot configure capture channel
cannot load driver module alsa

I have to unload and reload alsa to get past this stage.

I wouldn't be too sure that it is something wrong with the hdsp driver.
Too many weird things happen here. It would be interesting to know if
someone else has a Multiface running.

Marcus

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
