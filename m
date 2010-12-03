From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: HDA: Sound mutes when combination is below -48 dB
Date: Fri, 03 Dec 2010 12:58:03 +0100
Message-ID: <4CF8DB4B.6060006@ladisch.de>
References: <4CF8D4BA.8080904@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 54F652449D
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 12:56:11 +0100 (CET)
In-Reply-To: <4CF8D4BA.8080904@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
> I'm trying to nail down a strange behaviour. I have one "Master" and one
> "Speaker" (or "Headphone") volume control, each ranging from -48 dB to 0
> dB. Whenever the sum of "Master" and "Speaker" is below -48 dB, the
> output mutes.

A known SigmaTel bug.  Does your kernel already have these patches?
http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=de8c85f7840e5e29629de95f5af24297fb325e0b
http://git.alsa-project.org/?p=alsa-kernel.git;a=commit;h=a74ccea51d4314632a81d568d59bf885e5b09d93


Regards,
Clemens
