From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: aserver, smix
Date: Thu, 27 Feb 2003 03:24:07 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E5D0647.8040407@boosthardware.com>
References: <20030226180219.B32649@osiris.uid0.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www2.webhosting.cx (www2.webhosting.cx [207.44.198.86])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id TAA08004
	for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2003 19:35:57 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jozef Kosoru <zyzstar@uid0.sk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jozef Kosoru wrote:
> Hi!
> 
> A couple of questions:
> 
> I would like to ask what is the main purpose of the aserver. It can run
> on the same machine as the client only (AFAIK) and it cannot mix multiple
> client streams into the one device. So I've missed the point of that
> application -- is there something for which it could be good for?
> 
> ALSA plugin documentation mentions the 'smix' plugin. But I cannot find
> any further information nor the source code in the library for that. Is
> it something which will be introduced it the future ALSA releases?
> According the doc it is exactly something I've been looking for a long
> time; pcm device sharing.
> 

This has been discussed many times.

Currently the only ways to get pcm device sharing, I assume you mean 
using multiple devices as one virtual device are to write it up in your 
.asoundrc or use the patch which has been submitted but not applied to 
jack for this purpose.

The former is a little tricky to grok but it has been shown to work. The 
later requires a bit more of a deeper understanding of jack and coding.

There is info in the online docs. Just click on the link in the asoundrc 
  section for your device and the file is explained in depth.

If however you mean hardware mixing (multiple streams at the same time) 
then it is dependant on the device and the manufacturers supplied tech 
details.


-- 
Patrick Shirkey - Boost Hardware Ltd.
Http://www.boosthardware.com
Http://www.djcj.org - The Linux Audio Users guide
========================================

Being on stage with the band in front of crowds shouting, "Get off! No! 
We want normal music!", I think that was more like acting than anything 
I've ever done.

Goldie, 8 Nov, 2002
The Scotsman



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
