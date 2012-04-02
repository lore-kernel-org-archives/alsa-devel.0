From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: loading mixer control values from a different file
 when opening an device
Date: Mon, 02 Apr 2012 15:04:32 +0200
Message-ID: <4F79A3E0.6020501@ladisch.de>
References: <loom.20120401T171938-797@post.gmane.org>
	<4F795CEB.4090203@ladisch.de>
	<FC1850374E3CB245B9E97002380578E001CC639B@ILMAIL01.dspg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2CED2244AA
	for <alsa-devel@alsa-project.org>;
	Mon,  2 Apr 2012 15:00:48 +0200 (CEST)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 0760D20DCF
	for <alsa-devel@alsa-project.org>; Mon,  2 Apr 2012 09:00:55 -0400 (EDT)
In-Reply-To: <FC1850374E3CB245B9E97002380578E001CC639B@ILMAIL01.dspg.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ziv Haziz <Ziv.Haziz@dspg.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Ziv Haziz wrote:
> I have tried the method described in the link (using <> for loading
> other files) but I got an error - maybe I did not construct the small
> configuration file correctly.

Maybe, maybe not.  My crystal ball broke yesterday, so I do not know
what exactly you tried.

> Is the <> method works like the c preprocessor #include  directive?

Yes.

I put this into my ~/.asoundrc:

	pcm.test {
	        type plug
	        slave {
	                pcm "hw:0"
	                channels 2
	        }
	        </home/cladisch/my-ttable.conf>
	}

and this into ~/my-ttable.conf:

	ttable [
	        [ 0 1 ]
	        [ 1 0 ]
	]

and it works.


Regards,
Clemens
