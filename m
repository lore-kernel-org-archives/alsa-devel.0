From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [alsa-cvslog] alsa-lib: Implements support for
 capture/playback enums.
Date: Sat, 14 Oct 2006 12:24:10 +0100
Message-ID: <4530C8DA.9080308@superbug.demon.co.uk>
References: <ALOGGER1160773600.5@alsa-project.org>
	<Pine.LNX.4.61.0610140859220.8569@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from anchor-post-34.mail.demon.net (anchor-post-34.mail.demon.net
	[194.217.242.92])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3C7871A0
	for <alsa-devel@alsa-project.org>;
	Sat, 14 Oct 2006 13:24:11 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.61.0610140859220.8569@tm8103.perex-int.cz>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Fri, 13 Oct 2006, James Courtier-Dutton wrote:
> 
>> +	{" Playback Enum", CTL_PLAYBACK_ENUM},
>> +	{" Capture Enum", CTL_CAPTURE_ENUM},
>> +	{" Enum", CTL_GLOBAL_ENUM},
> 
> I don't like this. We already know, that it's the enum type, so it's not 
> required to put this type to control id name again.
> 
> Could you just check, if control id name ends with " Capture" or 
> " Playback" words and set CTL_XXXX_ENUM according that?
> 
> 						Jaroslav
> 

I would actually prefer to pass the info via the TLV interface.


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
