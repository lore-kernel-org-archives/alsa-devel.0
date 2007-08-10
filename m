From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: why would an scontrol think that it should have 2
 items instead of just 1?
Date: Fri, 10 Aug 2007 09:33:48 +0200
Message-ID: <1186731228.23920.1204693867@webmail.messagingengine.com>
References: <20070808152856.4122183d@jutz-fc6.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 284A410383B
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 09:33:49 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070808152856.4122183d@jutz-fc6.na.corp.dmxmusic.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "John L. Utz III" <john.utz@dmx.com>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

John L. Utz III wrote:
> The VT1618 codec has a register value that turns on the Surround Side
> Output (it's off by default)
> 
> I have implemented the control, but I am getting a really weird result,
> i have a bogus 'Item1' that shouldnt exist:
> 
> jutz-gntdv alsa-driver # amixer sset Side On
> Simple mixer control 'Side',0
>   Capabilities: pvolume pswitch enum
>   Items: 'On' 'Off'
>   Item0: 'On'
>   Item1: 'On'
> jutz-gntdv alsa-driver # amixer sset Side Off
> Simple mixer control 'Side',0
>   Capabilities: pvolume pswitch enum
>   Items: 'On' 'Off'
>   Item0: 'Off'
>   Item1: 'On'

How does this control look like in the output of "amixer controls"?


Regards,
Clemens
