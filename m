From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: Additing a new Hardware Specific feature in the
	ALSA	driver
Date: Mon, 22 Dec 2008 10:01:33 +1300
Message-ID: <494EAEAD.3080001@audioscience.com>
References: <35fa40850812200554y7523520aq27a427732ab87a8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id EDDAA2447E
	for <alsa-devel@alsa-project.org>; Sun, 21 Dec 2008 22:01:37 +0100 (CET)
Received: from [192.168.1.100]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0KC800F97VQLL540@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Mon, 22 Dec 2008 10:01:34 +1300 (NZDT)
In-reply-to: <35fa40850812200554y7523520aq27a427732ab87a8e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: SUBHRANIL CHOUDHURY <subhra85@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

SUBHRANIL CHOUDHURY wrote:
> Dear all,
> I am new to ALSA  programming.
> Suppose if i have to add some hardware specific feature in the ALSA sound
> driver and expose to the application via the ALSA library, how can do that?
>
> Please reply if you have some inputs.
> Anything is welcome.
> Thanks in advance.
>   
Please give more information about the kind of feature.
Standard alsa controls support arrays of integers, boolean, bytes or
enumerated lists of strings as controls.

Beyond that you can consider using the hwdep facility which basically
gives you a special device file which can implement your special file
operations  eg ioctl

regards

Eliot
