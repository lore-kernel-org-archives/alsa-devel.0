From: Jonathan Woithe <jwoithe@just42.net>
Subject: Re: Help requested: new HSS1394 MIDI back-end
Date: Sat, 9 Jun 2012 22:26:28 +0930
Message-ID: <20120609125628.GA6607@marvin.atrad.com.au>
References: <mailman.786.1339244201.2490.alsa-devel@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	by alsa0.perex.cz (Postfix) with ESMTP id 816D124477
	for <alsa-devel@alsa-project.org>;
	Sat,  9 Jun 2012 14:56:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <mailman.786.1339244201.2490.alsa-devel@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jonathan Woithe <jwoithe@just42.net>, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Sean M. Pappalardo - D.J. Pegasus wrote:
> > As soon as I start the JACK server to handle the audio interface on
> > the SCS.1m, the ALSA driver stops sending MIDI for that device unless
> > I stop JACK and power-cycle the device. Its last words are:
> > F0 00 01 60 48 53 53 0F 03 00 03 00 00 0B 01 F7
> 
> This is a ping response (tag F3).  Apparently, Jack's FFADO driver
> reinitializes the device and registers its own address for received
> packets.  Since it does _not_ handle MIDI messages, it really should
> not do this.

If we're talking about the ARM handler for HSS1394 messages, then I suspect
the reason it sets this up is that Pieter initially fully intended for FFADO
to pass these messages back.  Obviously if this were to be done then an ARM
handler would be necessary, but that's not how things are panning out.  To
prevent the ARM handler being registered by FFADO it should only be ncessary
to comment out the initMessageHandler() call in the ScsDevice::discover()
method.  I'm happy to make this change since it seems to make sense to do so
given these latest developments.  A preliminary approach is in FFADO svn
revision 2163 if you want to check it out.  Note that this will break
FFADO's test-scs program - a detail I'll tidy up if the overall approach
seems to work.

The other related issue is whether the other device setup done by FFADO
interferes with the MIDI stream transmission.  I guess that's most easily
tested by trying FFADO rev 2163 and seeing if there are other issues
remaining.

Regards
  jonathan
