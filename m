From: Damon Chaplin <damon@karuna.eclipse.co.uk>
Subject: Re: Problem with CME UF5 MIDI keyboard master
	volume	slider
Date: Tue, 07 Aug 2007 17:18:07 +0100
Message-ID: <1186503487.3160.26.camel@localhost.localdomain>
References: <1186223690.3246.11.camel@localhost.localdomain>
	<1186396868.28794.1203930879@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mra05.ch.as12513.net (mra05.ch.as12513.net [82.153.254.73])
	by alsa0.perex.cz (Postfix) with ESMTP id 093D410384A
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Aug 2007 18:22:14 +0200 (CEST)
In-Reply-To: <1186396868.28794.1203930879@webmail.messagingengine.com>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2007-08-06 at 12:41 +0200, Clemens Ladisch wrote:
> Damon Chaplin wrote:
> > I have a CME UF5 MIDI keyboard (USB), which mostly works fine with ALSA.
> > 
> > However if I move the Master Volume slider I stop getting MIDI events -
> > I have to disconnect the snd_seq port and reconnect it to get MIDI
> > events working again.
> 
> Is there any error message in the system log when this happens?

No, I don't think so. You mean /var/log/messages?


> > Also, I wanted to try the rawmidi test app, but what would the device ID
> > be?
> 
> Have a look at the output of "amidi -l".

Thanks. I've got rawmidi working, and it doesn't seem to have a problem
with the master volume slider. So I guess it is an alsa-seq issue.

If I move the slider I get this in rawmidi (4 lines for each increment):

read f0
read 01
read 7f
read 7e

read f0
read 01
read 7f
read 7d


Are they valid MIDI messages?

Damon
