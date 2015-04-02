From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Fw: Using loopback card to Connect GSM two way
	call	to the real sound card UDA1345TS
Date: Thu, 02 Apr 2015 17:08:40 +0200
Message-ID: <551D5B78.60703@ladisch.de>
References: <1425878251963.1340@tataelxsi.co.in>	<1425878360800.70892@tataelxsi.co.in>,
 <54FD552C.7020902@ladisch.de>,
 <1425922601141.50130@tataelxsi.co.in>	<1425964490006.15084@tataelxsi.co.in>,
 <54FECC69.9020600@ladisch.de>	<1427510661706.37789@tataelxsi.co.in>,
 <551D0F35.6010709@ladisch.de> <1427970980529.96067@tataelxsi.co.in>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 06745260569
 for <alsa-devel@alsa-project.org>; Thu,  2 Apr 2015 17:08:42 +0200 (CEST)
In-Reply-To: <1427970980529.96067@tataelxsi.co.in>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Srinivasan S <srinivasan.s@tataelxsi.co.in>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-audio-dev@lists.linuxaudio.org" <linux-audio-dev@lists.linuxaudio.org>
List-Id: alsa-devel@alsa-project.org

Srinivasan S wrote:
> I didn't understand what is 'two channel devices' does

The two channels are "left" and "right".

> Regarding bindings as you explained"bindings.x y" or "bindings { x y }" maps channel x of this device to
> channel y of the slave device.
>
> I didn't understand channel x of this device means is it the real sound card??? which is the current device ie., channel x of this device means???
>
> I didn't understand channel y of the slave device means??..  ie., which is slave device here????

"This device" is the virtual device that is defined.
The slave device is the device whose name is specified with "slave.pcm".


Regards,
Clemens
