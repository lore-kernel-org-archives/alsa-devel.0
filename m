From: "guan yim" <guanyim@hotmail.com>
Subject: Re: 0.9.8 lib + 1.0.6a driver + old sblive = no ac3passthrough
Date: Tue, 14 Dec 2004 11:17:16 +0200
Message-ID: <BAY22-F231E9515627185548335F1AFAC0@phx.gbl>
References: <1103004608.13301.3.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from hotmail.com (bay22-f23.bay22.hotmail.com [64.4.16.73])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A39C22A6
	for <alsa-devel@alsa-project.org>; Tue, 14 Dec 2004 10:18:05 +0100 (MET)
In-Reply-To: <1103004608.13301.3.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: rlrevell@joe-job.com
Cc: alsa-devel@alsa-project.org, pranay_k@hotmail.com
List-Id: alsa-devel@alsa-project.org

Hi Lee,

Thank you very much. I should now using all lib and drivers with matched 
version.

Thanks
guanyim

>From: Lee Revell <rlrevell@joe-job.com>
>To: guan yim <guanyim@hotmail.com>
>CC: alsa-devel@alsa-project.org, pranay_k@hotmail.com
>Subject: Re: [Alsa-devel] 0.9.8 lib + 1.0.6a driver + old sblive = no 
>ac3passthrough
>Date: Tue, 14 Dec 2004 01:10:08 -0500
>
>On Tue, 2004-12-14 at 06:20 +0200, guan yim wrote:
> > Why I couldn't mix different
> > version of lib and driver? Please tell me the reason.
>
>Because you are not supposed to do that.  Your ALSA lib and ALSA driver
>version should match.
>
>In this specific case it is because the device changed from hw:x,3 to
>hw:x,2.  But if your ALSA lib version matched then this change would not
>be visible.
>
>Lee
>
>
>
>-------------------------------------------------------
>SF email is sponsored by - The IT Product Guide
>Read honest & candid reviews on hundreds of IT Products from real users.
>Discover which products truly live up to the hype. Start reading now.
>http://productguide.itmanagersjournal.com/
>_______________________________________________
>Alsa-devel mailing list
>Alsa-devel@lists.sourceforge.net
>https://lists.sourceforge.net/lists/listinfo/alsa-devel

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
