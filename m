From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Determining the plugins being used?
Date: Tue, 13 Sep 2011 08:54:14 +0200
Message-ID: <4E6EFE16.4040902@ladisch.de>
References: <CAE3TgXGk9uaK0ESwUj2OGXKjBhRpi8tUgQXRT8GOMHLhX8ELGg@mail.gmail.com>	<4E6E6C28.1070009@ladisch.de>
	<CAE3TgXEWbnacMSbfgor4gk54ADDY60prBHu4mX3aSLmYDO6AsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 811DC244D9
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 08:53:56 +0200 (CEST)
In-Reply-To: <CAE3TgXEWbnacMSbfgor4gk54ADDY60prBHu4mX3aSLmYDO6AsQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Toy <rtoy@google.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Raymond Toy wrote:
> On Mon, Sep 12, 2011 at 1:31 PM, Clemens Ladisch <clemens@ladisch.de> wrote:
> > Raymond Toy wrote:
> > > Is there a way to determine the plugins being used?
> >
> > Not really.  snd_pcm_type() gives you the topmost plugin's type.

The pulse plugin typically is the topmost plugin.  However, you won't be
able to differentiate between 'plain' hw and dmix devices this way
because both often have a plug plugin on top.

> Bummer.  So the only hacky way is to look at the output of snd_pcm_dump,
> then?

Well, there is the even more hacky way of sifting through /proc/asound/
files to see who is accessing the hw device, but let's pretend I didn't
mention it ...

snd_pcm_dump() was designed for debugging only, but at the moment there
is no better way.


Regards,
Clemens
