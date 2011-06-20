From: Pavel Hofman <pavel.hofman@ivitera.com>
Subject: alsa-lib rate plugins - float samples
Date: Mon, 20 Jun 2011 09:35:12 +0200
Message-ID: <4DFEF830.6040400@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cable.insite.cz (twistwrist.pilsfree.net [78.108.108.109])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B4A71037FF
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 09:35:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by cable.insite.cz (Postfix) with ESMTP id C0C1FA1A40B30
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 09:35:17 +0200 (CEST)
Received: from cable.insite.cz ([10.109.23.231])
	by localhost (server.insite.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KI87SbTYCwTZ for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 09:35:17 +0200 (CEST)
Received: from [192.168.1.20] (sara.insite.cz [192.168.1.20])
	(Authenticated sender: pavel)
	by cable.insite.cz (Postfix) with ESMTPSA id 882F0A1A32346
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 09:35:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

This is probably a question for Jaroslav Kysela. The better-quality rate
plugins offer float resolution, but currently we are deliberately
loosing information by down-converting to s16 in plugin_rate API
(convert_s16). In rate_samplerate.c, the samples are up-converted to
float before calling the libsamplerate API. Speex offers float API too,
while we are using the int16 one.

There are two ways to handle this:

A. Implementing the generic "convert" API function for these plugins,
handling the sample - float conversion in each plugin individually.

B. Extending the pcm_rate API (pcm_rate.h) with a new optional function
convert_float.

Since the conversion from general sample format to float is not trivial
(using the plugin_ops.h operations), I would be inclined to suggest the
extension (well I have it hacked already :-) ). On the other hand, the
conversion routine can be located in some common code shared by all the
plugins involved and we could keep the existing API, using the generic
convert function.


Thanks a lot for suggestions.

Best regards,

Pavel.
