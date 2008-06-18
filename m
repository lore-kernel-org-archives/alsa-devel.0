From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Listing raw midi devices "The Right Way"?
Date: Wed, 18 Jun 2008 16:27:38 +0200
Message-ID: <48591B5A.9070808@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id B4526103817
	for <alsa-devel@alsa-project.org>;
	Wed, 18 Jun 2008 16:27:40 +0200 (CEST)
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id E4C8A123368
	for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2008 10:27:39 -0400 (EDT)
Received: from [10.1.2.24] (gw.dmc-one.com [213.238.46.194])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0585413C21
	for <alsa-devel@alsa-project.org>; Wed, 18 Jun 2008 10:27:38 -0400 (EDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jacob Ole Juul Kolding wrote:
> I already found a code example that reads raw midi packages form a
> specified device but I need to have a complete list of ALL raw midi
> capable devices and ports on the system.
>
> What is the "Right Way" for an app to build such a list?

See the source code of amidi.

You probably should be using the sequencer instead of the raw MIDI
interface, in which case look at the source code of arecordmidi.


HTH
Clemens
