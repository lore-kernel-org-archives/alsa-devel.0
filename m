From: "John L. Utz III" <john.utz@dmx.com>
Subject: Solved! Tnx Clemens! Re: why would an scontrol think
 that it should have 2 items instead of just 1?
Date: Fri, 10 Aug 2007 10:46:46 -0700
Message-ID: <20070810104646.23ce2001@jutz-fc6.na.corp.dmxmusic.com>
References: <20070808152856.4122183d@jutz-fc6.na.corp.dmxmusic.com>
	<1186731228.23920.1204693867@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.dmxmusic.com (mail.dmxmusic.com [199.201.237.35])
	by alsa0.perex.cz (Postfix) with ESMTP id EDC482438B
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Aug 2007 19:42:08 +0200 (CEST)
In-Reply-To: <1186731228.23920.1204693867@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Clemens!

Tnx for the question!

On Fri, 10 Aug 2007 09:33:48 +0200
"Clemens Ladisch" <cladisch@fastmail.net> wrote:

> John L. Utz III wrote:
> > The VT1618 codec has a register value that turns on the Surround
> > Side Output (it's off by default)
> > 
> > I have implemented the control, but I am getting a really weird
> > result, i have a bogus 'Item1' that shouldnt exist:
> > 
> > jutz-gntdv alsa-driver # amixer sset Side On
> > Simple mixer control 'Side',0
> >   Capabilities: pvolume pswitch enum
> >   Items: 'On' 'Off'
> >   Item0: 'On'
> >   Item1: 'On'
> > jutz-gntdv alsa-driver # amixer sset Side Off
> > Simple mixer control 'Side',0
> >   Capabilities: pvolume pswitch enum
> >   Items: 'On' 'Off'
> >   Item0: 'Off'
> >   Item1: 'On'
> 
> How does this control look like in the output of "amixer controls"?

This is an *excellent* question because the results of looking are damn
odd! :

jutz-gntdv alsa-driver # amixer controls | grep Side
numid=10,iface=MIXER,name='Jack Side'
numid=9,iface=MIXER,name='Side'
numid=4,iface=MIXER,name='Side Playback Switch'
numid=3,iface=MIXER,name='Side Playback Volume'

I think that my 'Side' enable twiddler was colliding with my 'Side'
Volume and Switch twiddlers, because once i changed 'Side' to 'Side
Enable' the problem went away:

jutz-gntdv alsa-driver # amixer sget Side\ Enable
Simple mixer control 'Side Enable',0
  Capabilities: enum
  Items: 'On' 'Off'
  Item0: 'Off'




> 
> Regards,
> Clemens
> 
