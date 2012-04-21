From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Logical device name for 4-channel microphones?
Date: Sat, 21 Apr 2012 15:24:12 +0300
Message-ID: <1335011052.2268.18.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id E50E4103D92
	for <alsa-devel@alsa-project.org>;
	Sat, 21 Apr 2012 14:24:15 +0200 (CEST)
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 9D413209C3
	for <alsa-devel@alsa-project.org>; Sat, 21 Apr 2012 08:24:14 -0400 (EDT)
Received: from [91.153.216.147] (a91-153-216-147.elisa-laajakaista.fi
	[91.153.216.147])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 151BA48254F
	for <alsa-devel@alsa-project.org>; Sat, 21 Apr 2012 08:24:13 -0400 (EDT)
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

Hi,

What is the best source of information about device names ("front",
"surround40" etc)? Is it the DeviceNames wiki page[1]? That page was
slightly out of date, so I updated and expanded it (review would be
welcome).

I'm looking for information specifically about capture device names. The
wiki page didn't help me there, as it only listed playback device names.
My problem is that I'd like to make Pulseaudio handle 4-channel webcam
microphones[2], but I'm not aware of any input device names for
4-channel devices. Are there such device names? If not, what should be
done?

Pulseaudio could just use "hw", but I'd prefer there to be a standard
device name for 4-channel mics. AFAIK, at playback side, some surround
implementations are using multiple devices on one card, and using "hw"
wouldn't work in those cases, while e.g. "surround40" can use the
multiple devices behind the scenes. I would guess that the same could be
the case with some multichannel microphones, and therefore a logical
name like "fourchannelmic" would be better than using "hw".

[1] http://www.alsa-project.org/main/index.php/DeviceNames
[2] https://bugs.freedesktop.org/show_bug.cgi?id=45813

-- 
Tanu
