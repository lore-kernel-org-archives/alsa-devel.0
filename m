From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: User space drivers
Date: Fri, 03 Aug 2007 14:55:23 +1200
Message-ID: <46B2991B.6080402@audioscience.com>
References: <C7A98C6EB85FFF4FAE03BD695D68EC7601239680@NAEX05.na.qualcomm.com>
	<46B27108.1000409@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 388AB24391
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Aug 2007 04:55:53 +0200 (CEST)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JM600AQ9G4CZA30@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Fri, 03 Aug 2007 14:55:24 +1200 (NZST)
In-reply-to: <46B27108.1000409@superbug.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

James Courtier-Dutton wrote:
> Wallace, Brooke wrote:
>> Hi,
>>  
>> I've been trying to sort thru the ALSA docs and am starting to get the
>> impression that all of the existing drivers are written as Kernel
>> Modules. Doesn't this mean that they are running in Kernel space and
>> infact are not User Space drivers? Shouldn't there be an ALSA Drivers
>> API document that covers an API that User Space Drivers can use? I must
>> be mssing something here...

What you may be looking for is the plugins API.
Take a look at the alsa-plugins source, there are some examples of
things that talk to other userspace things (E.g. jack or pulseaudio
plugin) or other non alsa drivers (E.g. oss or freebob)

http://hg-mirror.alsa-project.org/alsa-plugins/

But remember not to put any GPL code in your non-gpl driver ;)

As others have mentioned you may not be able to get much help for this
kind of endeavour if you are not prepared to "show us the source".

--
Eliot
