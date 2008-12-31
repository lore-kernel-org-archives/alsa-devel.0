From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Control interconnection information API?
Date: Thu, 01 Jan 2009 12:01:47 +1300
Message-ID: <495BF9DB.2060202@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 1FDCF1037F4
	for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2009 00:01:53 +0100 (CET)
Received: from [192.168.1.100]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp3.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0KCR00E11JYZW900@smtp3.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 01 Jan 2009 12:01:48 +1300 (NZDT)
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

New Year's Greetings,


something that seems to be lacking in the ALSA API, or at least the way
of describing controls (by name only), is any concept of the
connectivity between the various controls and the codecs and output
terminals.

One use for such information is to build a GUI that shows this
connectivity (instead of the current bucket'o'controls approach).

Now there are a couple of special cases:

* HDA driver exports the codec widget information via a proc file,
allowing the codecgraph tool to visualise the connections.
Widgets have numeric IDs and list the IDs of widgets that connect to
their inputs.

* ASoC DAPM (which I (not being an ASoC developer or user) have mostly
been skimming over in this list).

Reading this
http://www.mjmwired.net/kernel/Documentation/sound/alsa/soc/dapm.txt
3. Codec Widget Interconnections. I can see that there are lists of
connections.  I'm not sure if these are visible to userspace via any API?


So:
Can either of these schemes be generalised to all ALSA drivers?
Is there some other way to reveal the information (Connections TLV, new
API etc?)
Does anybody else thing this is worth pursuing, or is it just me?


regards

--
Eliot Blennerhassett
AudioScience Inc
