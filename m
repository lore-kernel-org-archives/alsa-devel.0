From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: question about sampling rate
Date: Thu, 31 Aug 2006 12:50:12 +0200
Message-ID: <1157021412.24248.269842218@webmail.messagingengine.com>
References: <54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
	<7034e7b50607181827u6ddc9cb5s8585978e80a7af9b@mail.gmail.com>
	<20060719122905.GB24800@turing.informatik.uni-halle.de>
	<7034e7b50608091945r39ddaeeevda675f05251be9cb@mail.gmail.com>
	<1155315961.10237.268179763@webmail.messagingengine.com>
	<7034e7b50608302232w2b7279b3qf66acaeca54f1e2b@mail.gmail.com>
	<1157012237.11592.269833216@webmail.messagingengine.com>
	<7034e7b50608310122na613dcesf642709d586fbde5@mail.gmail.com>
	<1157014147.13855.269835275@webmail.messagingengine.com>
	<7034e7b50608310210h59217352tb99c8189b228a4e3@mail.gmail.com>
	<7034e7b50608310250w77fe2d21va4b0593b66f5d9d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D96AF170
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Aug 2006 12:50:13 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <7034e7b50608310250w77fe2d21va4b0593b66f5d9d8@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Grace Baldonasa <gbaldona@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Grace Baldonasa wrote:
> Got another question, following to my previos emails, do I have to adjust my
> streaming size since the sampling freq used when audio data was converted is
> not supported by the speaker?

ALSA will allow only those sample rates/formats that the driver says it
supports (in the snd_pcm_hardware structure, and with any constraints
set in the open callback).


HTH
Clemens

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
