From: Pierre Ossman <ossman@cendio.se>
Subject: Re: Non-continous channel map?
Date: Wed, 03 May 2006 14:43:51 +0200
Message-ID: <4458A587.2010403@cendio.se>
References: <44505C23.30109@cendio.se> <20060503120653.GA11243@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.cendio.se (mail.cendio.se [193.12.253.69])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9AFE5185
	for <alsa-devel@alsa-project.org>; Wed,  3 May 2006 14:43:53 +0200 (MEST)
In-Reply-To: <20060503120653.GA11243@turing.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Pierre Ossman wrote:
>> ALSA uses a rather strict default channel map, just a simple list.
> 
> Does it?  AFAIK ALSA devices just have a specific number of channels and
> leave the interpretation to the application.
> 
> The default channel order is just a convention.
> 

A convention that isn't followed is just as bad, if not worse, than no 
convention at all.

So what you're saying is that any application that wants to output more 
than one channel must have the user inform it of how channels are mapped?

-- 
Pierre Ossman                Telephone: +46-13-21 46 00
Cendio AB                    Web: http://www.cendio.com


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
