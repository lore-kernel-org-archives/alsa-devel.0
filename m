From: Pieter Palmers <pieter.palmers@student.kuleuven.ac.be>
Subject: ens1731 patch to enable rear output
Date: Thu, 16 Jan 2003 21:26:57 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301162126.57530.pieter.palmers@student.kuleuven.ac.be>
References: <FLELKBEJMNABMIPKPAGMEECNDAAA.pieter.palmers@student.kuleuven.ac.be>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <FLELKBEJMNABMIPKPAGMEECNDAAA.pieter.palmers@student.kuleuven.ac.be>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

It seems that my previous assumption was correct. I added a patch for the 
ens1370.c driver that enables the rear output.
It seems to be a mirror of the front output, but the 'surround' slider in 
alsamixer controls volume separately from the output.

By the way: the CVS server at sourceforge still refuses connections. So I 
applied this to the latest CVS version I had locally.

Pieter


-------------------------
1947,1950d1946
< #ifdef CHIP1371
<       /* enable the rear outputs */
<       ensoniq->cssr |= (1 << 26);
< #endif
--------------------------



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
