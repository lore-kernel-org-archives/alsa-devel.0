From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Need to know SBLive Chip difference
Date: Tue, 30 Mar 2004 12:52:16 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40695F70.4050808@superbug.demon.co.uk>
References: <Sea2-F4p4hZDnrasn3c00005bee@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-34.mail.demon.net (anchor-post-34.mail.demon.net [194.217.242.92])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA13482
	for <alsa-devel@alsa-project.org>; Tue, 30 Mar 2004 13:51:33 +0200
In-Reply-To: <Sea2-F4p4hZDnrasn3c00005bee@hotmail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: guan yim <guanyim@hotmail.com>
Cc: pzad@pobox.sk, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

guan yim wrote:
> FYI too, the Audigy 2001 I have been talking about is using the 
> following chips:
> 
> SIGMATEL
> STAC9721T
> LC5A01E
> 0201
> 
> CREATIVE
> Audigy(tm)
> CA0100-IDF
> (C) CREATIVE TECH'01
> 2BA70KW
> 
> I can have 6 channels output with this card. I think if creative uses 
> the SIGMATEL chip on that SBLive 2003 (say, "Audigy 2003") then it will 
> create same problem later :)
> 

Do any output channels work.
Just try stereo for "front" and "rear" and "center/lfe"
Also, what is the output from
lspci -n |grep 0401

Cheers
James



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
