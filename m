From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: 0.9.8 lib + 1.0.6a driver + old sblive = no ac3
	passthrough
Date: Tue, 14 Dec 2004 01:10:08 -0500
Message-ID: <1103004608.13301.3.camel@krustophenia.net>
References: <BAY22-F28708B2255DC9FF4966C4BAFAC0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 62DD22B0
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2004 07:10:12 +0100 (MET)
In-Reply-To: <BAY22-F28708B2255DC9FF4966C4BAFAC0@phx.gbl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: guan yim <guanyim@hotmail.com>
Cc: alsa-devel@alsa-project.org, pranay_k@hotmail.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-12-14 at 06:20 +0200, guan yim wrote:
> Why I couldn't mix different 
> version of lib and driver? Please tell me the reason.

Because you are not supposed to do that.  Your ALSA lib and ALSA driver
version should match.

In this specific case it is because the device changed from hw:x,3 to
hw:x,2.  But if your ALSA lib version matched then this change would not
be visible.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
