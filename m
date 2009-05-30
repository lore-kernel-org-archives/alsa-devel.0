From: Robert Hancock <hancockrwd@gmail.com>
Subject: SPDIF/AES input sample rate handling?
Date: Fri, 29 May 2009 21:59:43 -0600
Message-ID: <gvqavg$rav$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by alsa0.perex.cz (Postfix) with ESMTP id DB771247A1
	for <alsa-devel@alsa-project.org>;
	Sat, 30 May 2009 06:00:00 +0200 (CEST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1MAFjh-0004u0-Gr
	for alsa-devel@alsa-project.org; Sat, 30 May 2009 03:59:57 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 30 May 2009 03:59:57 +0000
Received: from hancockrwd by s0106000c41bb86e1.ss.shawcable.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sat, 30 May 2009 03:59:57 +0000
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

A question about how ALSA drivers should handle SPDIF or AES digital 
audio inputs: I may be eventually be writing an ALSA driver for an audio 
card which has multiple AES digital audio inputs. The card would support 
multiple sample rates on input with the provided input data being fed 
directly to software with no sample rate conversion. This raises the 
question of how to handle requests for a particular sample rate. If the 
user app requests recording at a sample rate of say 32KHz and we say 
"OK", and then they proceed to connect an input running at 44.1KHz 
sampling rate, the card will produce and the app will receive samples at 
a faster than expected rate. Presumably this is something the app just 
has to deal with, but will anything in the ALSA core/library puke 
because of it?

Or is there a better way to deal with this kind of situation?
