From: Ed Wildgoose <lists@wildgooses.com>
Subject: rme 9632 crackling when sound > 0db
Date: Mon, 12 Apr 2004 10:21:29 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <407A5F99.4040201@wildgooses.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from xunil.mail.wildgooses.com (xunil.mail.wildgooses.com [81.6.236.5])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id LAA18806
	for <alsa-devel@alsa-project.org>; Mon, 12 Apr 2004 11:21:44 +0200
Received: from localhost (Xunil [127.0.0.1])
	by xunil.mail.wildgooses.com (Postfix) with ESMTP id 4E7461707E2
	for <alsa-devel@alsa-project.org>; Mon, 12 Apr 2004 10:21:36 +0100 (BST)
Received: from wildgooses.com (unknown [192.168.105.1])
	by xunil.mail.wildgooses.com (Postfix) with ESMTP id ED4F41707E1
	for <alsa-devel@alsa-project.org>; Mon, 12 Apr 2004 10:21:35 +0100 (BST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi, I'm running kernel 2.6.5-mm1 with built-in alsa drivers.  Also, v 
1.04 of the various alsa utils, etc.

I'm playing (for example) Dido - No Angel, track "Isobel", and according 
to the hdspmixer tool, at the end of the track the drums have transients 
that go greater than 0db, and this causes nasty metallic crackles on my 
RME 9632 (tested with both Alsa and OSS interfaces).  Without looking at 
the code, I'm wondering if there is an overflow occuring, ie something 
unsigned going into a signed value and causing this...  However, it 
doesn't seem that likely, for example if you turn up the middle layer of 
mixer controls and then turn down the last layer of output mixer 
controls then as long as the red clip light isn't on then everything is 
still ok, ie the crackle isn't occuring as a result of the first layer 
of software mixing, it purely seems to be something happening *after* 
the last mixer control

You can also simulate this simply by turning up the mixer controls so 
that normal music starts to clip.  Same effect.

Two points to note, first I don't remember getting this on an alsa 
snapshot from about 1-2 months ago, so I'm thinking it's a driver issue, 
rather than a feature of this card?  Secondly, before now I couldn't use 
the card at all with many apps, I would just get constant over-runs and 
other problems.  So thankyou for fixing those problems!

Just a heads up, this card still doesn't work with mplayer 1.0 pre3.  
The sound appears to be playing too slowly, and several times a second 
there are "xruns" reported (which makes sense).  I will try and rip out 
the mplayer audio code and make up a test app so that I can experiment 
further with this. 

Thanks to everyone who has made Alsa what it is today!

Ed W


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
