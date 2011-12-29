From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Period time/size in adaptive USB - alignment to
	nrpacks?
Date: Thu, 29 Dec 2011 09:43:06 +0100
Message-ID: <16ced9db-de9c-476b-bb3c-7af436aab558@email.android.com>
References: <4EF8D3FB.8090109@ivitera.com>
	<d230c209-78cd-4f34-bba4-b778eb88471e@email.android.com>
	<4EFB763F.7030407@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 1D7431037EE
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 09:40:44 +0100 (CET)
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 3938721048
	for <alsa-devel@alsa-project.org>; Thu, 29 Dec 2011 03:40:41 -0500 (EST)
In-Reply-To: <4EFB763F.7030407@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pavel Hofman <pavel.hofman@ivitera.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Pavel Hofman wrote:
>Now please see the wireshark screenshot at
>http://personal.educity.cz/dustin/wireshark.png . Frame 1197 is the last
>URB of the period, with 960 bytes only. Yet the time distance around it
>is again 8 ms (12.808-12.816-12.824). The expected 5 ms lag appears 2
>URBs later, between frames 1201 and 1203 (12.832-12.837), all holding
>1536 bytes.

Wireshark shows the URBs when they are submitted, which
is in the completion handler of some previous URB.
This means that the timing of the submission has no
relation with its size.


Regards,
Clemens
