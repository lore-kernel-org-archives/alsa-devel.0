From: Martin Langer <martin-langer@gmx.de>
Subject: Re: bugs in usb midi alsa code?
Date: Thu, 7 Nov 2002 13:22:54 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021107122254.GE541@tuba.home>
References: <20021107093720.GB541@tuba.home> <Pine.HPX.4.33n.0211071107080.7735-100000@studcom.urz.uni-halle.de> <20021107102136.GD541@tuba.home> <20021107103402.GA3186@tuba.home>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id NAA18330
	for <alsa-devel@alsa-project.org>; Thu, 7 Nov 2002 13:21:27 +0100
Content-Disposition: inline
In-Reply-To: <20021107103402.GA3186@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: clemens@ladisch.de, ws@seh.de, nando@ccrma.Stanford.EDU, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 07, 2002 at 11:34:02AM +0100, Martin Langer wrote:
> On Thu, Nov 07, 2002 at 11:21:36AM +0100, Martin Langer wrote:
> > 
> 
> 
> tuba:/usr/local/src/alsa-cvs/alsa-lib/test# ./rawmidi -v -I /dev/snd/midi2    
> Using: 
> Input: /dev/snd/midi2
> Output: NONE
> open /dev/snd/midi2 for input failed
> Closing
> 

This is definitely not my day! Now I've tried /dev/midi2 instead of
/dev/snd/midi2. It's running so far. /dev/snd/midi2 doesn't exist.

sorry,
martin



tuba:/usr/local/src/alsa-cvs/alsa-lib/test# ./rawmidi -v -I /dev/midi2
Using: 
Input: /dev/midi2
Output: NONE
Read midi in
Press ctrl-c to stop
read fe
read fe
...


-- 
"2b|!2b"


-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
