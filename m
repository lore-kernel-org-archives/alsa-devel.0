From: Daniel Wagner <wagi@vis.ethz.ch>
Subject: Driver(s) for IEEE 1394 based break out boxes
Date: Mon, 12 Jul 2004 21:19:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040712191930.GA20382@vis.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.vis.ethz.ch (naboo.ethz.ch [129.132.17.66])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 200C5266
	for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2004 21:19:32 +0200 (MEST)
Received: from selonia.vis.ethz.ch (selonia.vis.ethz.ch [192.168.2.2])
	by mail.vis.ethz.ch (Postfix) with ESMTP id E5823741F8
	for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2004 21:19:30 +0200 (CEST)
Received: from wagi by selonia.vis.ethz.ch with local (Exim 3.35 #1 (Debian))
	id 1Bk6Ko-0005In-00
	for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2004 21:19:30 +0200
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

There're several IEEE 1394 based break out boxes on the market for
which no drivers exist for Linux [1] (The web site has a translation
to english, but the content seems to disappear, at least for the IEEE
1394 boxes.) .  The interesting fact about those boxes is that all
but one are using the same chip (dm1000).  Furthermore, the
communication protocol(s) between break out box and computer is
documented and "public" available.  Yes, you have to be member of those
groups to read the documents but in the general idea it's available.

Relevant standards are:
  IEC 61883
  1394ta AVC
  1394ta Audio and Music Data Transmission Protocol

I'm still trying to figure out what's the best way to write a driver.

On the on hand, there exists already the IEEE 1394 stack with IEC
61883 support in user-land.  I don't know if the libiec61883 is already
ready to use but still it exists.  As I understand the general idea
behind libraw1394 and libiec61883 is to do as much as possible in
users-pace.  Any application which wants to take advantage of IEEE 1394
based sound cards has to use those libraries.  I guess it means for
jack to have a new backend in order to use those cards.  But most
application wont be aware of this interface, I suppose.

On the other hand ALSA provides a well known interface which most
sound based application are using.  To write a new driver for a sound
card, you end up writing an ALSA kernel driver because libasound is
not designed to use other interfaces than the ALSA kernel interface
(this is an assumption).  So it is not possible to use libraw1394 and
libiec61883.  A new kernel driver has to be written with implements
those parts.  Of course it needs some more things but I'm just writing
my lousy ordered thoughts down.

The question is which way to go?  Get the break out boxes working with
the existing libraries or write an ALSA driver which implements those
parts again?  Personaly, I think ALSA might be the better idea but it
does not make use of the already written code.  Maybe there exists a
better way...

thanks,
daniel

[1]  http://www.soundkartenkatalog.de/deu2/pi-1117011340.htm?categoryId=28



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
