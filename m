From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Gigabyte 880GM-USB3 MIDI and Dolby 5.1/7.1 issues
Date: Mon, 13 Dec 2010 09:52:52 +0100
Message-ID: <4D05DEE4.5020004@ladisch.de>
References: <AANLkTimb5AnPm13d0kpMmjq4nOTH0dXA_VyO2CXbr_bQ@mail.gmail.com>	<4D00C2EA.1060204@ladisch.de>	<AANLkTikTKQkQqAMddajMHCk1trj=4ncvnbOMLbB-Ctjo@mail.gmail.com>	<4D00D39D.2090001@ladisch.de>
	<AANLkTimSGFDXAkGt3BQ8fxc5hQZecp=-1Vtdp4vDzbSt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id AAB841037E3
	for <alsa-devel@alsa-project.org>; Mon, 13 Dec 2010 09:50:05 +0100 (CET)
In-Reply-To: <AANLkTimSGFDXAkGt3BQ8fxc5hQZecp=-1Vtdp4vDzbSt@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jonathan Gardner <jgardner@jonathangardner.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jonathan Gardner wrote:
> On Thu, Dec 9, 2010 at 5:03 AM, Clemens Ladisch <clemens@ladisch.de> wrote:
>> Jonathan Gardner wrote:
>>> So should I work with PulseAudio to get their GUI working with my
>>> particular situation?
>>
>> I'm not sure if your situation is one that PA actually wants to handle.
> 
> I don't understand what you mean, since I am not familiar with ALSA or
> PulseAudio. Could someone clarify?

Sorry, my statement seems to imply issues that aren't there.

The problem you have is that PulseAudio does not show all the mixer
controls that you need.  I do not know whether this is because the
driver does not give the correct information about these controls, or
because PulseAudio does not interpret it correctly, or because
PulseAudio does not support this situation.

Try asking on the PA list how to configure your system.


Regards,
Clemens
