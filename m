From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: SPDIF/AES input sample rate handling?
Date: Tue, 02 Jun 2009 17:20:13 +1200
Message-ID: <4A24B68D.8060009@audioscience.com>
References: <gvqavg$rav$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 3AEDF243CD
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 07:20:51 +0200 (CEST)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0KKL00LAHITT0Y30@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 02 Jun 2009 17:20:18 +1200 (NZST)
In-reply-to: <gvqavg$rav$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Robert Hancock wrote:
> A question about how ALSA drivers should handle SPDIF or AES digital 
> audio inputs: I may be eventually be writing an ALSA driver for an audio 
> card which has multiple AES digital audio inputs. The card would support 
> multiple sample rates on input with the provided input data being fed 
> directly to software with no sample rate conversion. This raises the 
> question of how to handle requests for a particular sample rate. If the 
> user app requests recording at a sample rate of say 32KHz and we say 
> "OK", and then they proceed to connect an input running at 44.1KHz 
> sampling rate, the card will produce and the app will receive samples at 
> a faster than expected rate. Presumably this is something the app just 
> has to deal with, but will anything in the ALSA core/library puke 
> because of it?

I think it will just run faster.

If you *already* have the 44.1kHz input connected when the app tries to
set up the stream, then your driver can report that it is only capable
of 44.1, and the app or ALSA plug layer will be forced to do resampling.

aside: does it make sense to allow recording at all if there is no valid
input clock?

I'm not sure of the best way to dynamically change such a constraint
when the input changes.

--
Eliot
