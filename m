From: Henning Thielemann <alsa@henning-thielemann.de>
Subject: how to handle buffer underrun in a softsynth
Date: Mon, 28 Nov 2011 17:06:03 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1111281636560.13399@anubis.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgate5.urz.uni-halle.de (mailgate5.urz.uni-halle.de
	[141.48.3.10]) by alsa0.perex.cz (Postfix) with ESMTP id BD2ED1038C3
	for <alsa-devel@alsa-project.org>; Mon, 28 Nov 2011 17:06:10 +0100 (CET)
Received: from mserv3.urz.uni-halle.de ([141.48.3.161])
	by mlucom18.urz.uni-halle.de with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.77) id 1RV3ic-0003Ff-5d for <alsa-devel@alsa-project.org>
	; Mon, 28 Nov 2011 17:06:10 +0100
Received: from hermes.informatik.uni-halle.de ([141.48.9.46])
	by mail.uni-halle.de
	(Sun Java(tm) System Messaging Server 6.3-15.01 (built Mar 21 2011;
	32bit)) with ESMTP id <0LVD003FPOQ3L950@mail.uni-halle.de> for
	alsa-devel@alsa-project.org; Mon, 28 Nov 2011 17:06:03 +0100 (CET)
Received: from anubis.informatik.uni-halle.de
	(anubis.informatik.uni-halle.de [141.48.165.107])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)	by hermes.informatik.uni-halle.de
	(Postfix)
	with ESMTPS id DB3204E3256E	for <alsa-devel@alsa-project.org>; Mon,
	28 Nov 2011 17:06:03 +0100 (CET)
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
List-Id: alsa-devel@alsa-project.org


I have written a software synthesizer in Haskell that fetches MIDI events 
from ALSA sequencer and plays the rendered signal via ALSA pcm. However it 
cannot cope correctly with buffer underruns.

I tried to learn the correct way from the miniFMsynth example of
    http://alsamodular.sourceforge.net/alsa_programming_howto.html
   however this program floods my terminal with buffer underrun messages 
without even being connected to any MIDI event source. This is independent 
from how large I choose the BUFSIZE constant.

I use:

$ pkg-config --modversion alsa
1.0.14

  Also, as far as I understand, that program allows to start notes only at 
block boundaries. This way it can ignore the timestamps of the incoming 
events. But this is crucial for me: I want to allow large blocksizes 
and thus I must allow notes to start anywhere inside a block.
  Now when I detect a buffer underrun on writing a block to an ALSA pcm 
sink, I like to know the time gap in order to adjust the timestamps of the 
incoming MIDI events.

My question in short is: Is there an example software synthesizer as 
simple as miniFMsynth, that works (on my machine), supports note start 
within a block and copes with buffer underruns in a reasonable way? If no 
working example, is there some documentation on how this is intended to 
work?


Thank you for your help
Henning
