From: Marcus Andersson <054185595@telia.com>
Subject: Re: ALSA Hammerfall DSP driver
Date: Sat, 25 May 2002 21:03:58 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3CEFE01E.AE1D59A6@telia.com>
References: <200205232232.g4NMW9b04424@post2.fast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from maild.telia.com (maild.telia.com [194.22.190.101])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA22448
	for <alsa-devel@alsa-project.org>; Sat, 25 May 2002 20:59:15 +0200
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
> i know its mundane, but are you sure you have the cables hooked up
> correctly?

I booted windows to check the setup, and it works.

 you can set the passthru control
> 
>            amixer cset name=Passthru 1
> 
> and check that passthru is working OK.

This doesn't work either.

# alsactl store 1
alsactl: get_control:359: Unknown control type: 6

Is this good or bad?

At some point the 'MIDI STATE out' is lit and stays lit. I don't use
MIDI. (I think, if not aplay tries to play a wav as midi.)

Marcus

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
