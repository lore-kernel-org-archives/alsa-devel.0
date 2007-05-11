From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Capturing MIDI
Date: Fri, 11 May 2007 18:39:05 +0200
Message-ID: <1178901545.25538.1189348011@webmail.messagingengine.com>
References: <4642E7E1.8070800@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 8910824428
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2007 18:39:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4642E7E1.8070800@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Steve Merrony <merrony@googlemail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Steve Merrony wrote:
> I'd like to add a new feature to the software - a facility to simply
> record to a standard MIDI file anything that the program produces.
> 
> Is there a recommended library for C++ ALSA programs to use for handling 
> (writing) standard MIDI files?

ALSA handles sound devices; SMFs are something completely different.

I don't know of any general-purpose SMF library.
Have a look at arecordmidi.c.


HTH
Clemens
