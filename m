From: Nicolas Boullis <nboullis@debian.org>
Subject: "softswitch" feature?
Date: Tue, 20 Jan 2009 01:59:30 +0100
Message-ID: <20090120005929.GA4003@tryphon.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EFB21037E3
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 01:59:36 +0100 (CET)
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 575AB81801E
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 01:59:33 +0100 (CET)
Received: from tryphon.home (tryphon.debian.net [82.66.113.220])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 6B41081805A
	for <alsa-devel@alsa-project.org>; Tue, 20 Jan 2009 01:59:31 +0100 (CET)
Received: from localhost ([127.0.0.1]) by tryphon.home with esmtp (Exim 4.63)
	(envelope-from <nboullis@tryphon.debian.net>) id 1LP4xm-0005av-Sy
	for alsa-devel@alsa-project.org; Tue, 20 Jan 2009 01:59:30 +0100
Received: from tryphon.home ([127.0.0.1])
	by localhost (tryphon.home [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ev+BIo5g4gp for <alsa-devel@alsa-project.org>;
	Tue, 20 Jan 2009 01:59:30 +0100 (CET)
Received: from irma.home ([192.168.18.8] ident=Debian-exim)
	by tryphon.home with esmtp (Exim 4.63)
	(envelope-from <nboullis@tryphon.debian.net>) id 1LP4xm-0005aq-Ee
	for alsa-devel@alsa-project.org; Tue, 20 Jan 2009 01:59:30 +0100
Received: from nboullis by irma.home with local (Exim 4.63)
	(envelope-from <nboullis@tryphon.debian.net>) id 1LP4xm-00014L-3n
	for alsa-devel@alsa-project.org; Tue, 20 Jan 2009 01:59:30 +0100
Content-Disposition: inline
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

Hello,

I'd like to implement a PCM device with 2 slaves, that sends its stream 
to either slave according to a user-defined switch.

I need this for a card that is able to play either 2-channel 16-bit 
big-endian frames to its analog output or IEC958 frames to its digital 
output. I'd like to setup a "default" device for this card that send 
sound to either output according to a switch.

Is such a thing feasible with the existing plugins?

If not, do you think it would be easy to implement?

Note that, although my card implements this as 2 separate devices, they 
can't be open simultaneously since both use the same hardware fifo. 
Hence, I think it would require that the unused slave not be open.

I also can imagine othen applications for such a feature, such as with a 
VOIP application to use either a standard soundcard connected to 
loudspeakers and a microphone, or a bluetooth headset.


Reagrds,

Nicolas

PS: FWIW, the card I'm talking about is a hardware MPEG decoder board, 
whose driver I'm the maintainer of, an which implements an ALSA driver 
for its audio part. It's current card-specific configuration is 
available at
  http://freehg.org/u/nboullis/em8300/file/tip/modules/EM8300.conf
All comments are welcome.
