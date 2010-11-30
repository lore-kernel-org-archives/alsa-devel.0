From: Eliot Blennerhassett <ewblen+alsadevel@gmail.com>
Subject: Help wanted: emachines em350 internal mic
Date: Tue, 30 Nov 2010 19:56:04 +1300
Message-ID: <AANLkTinmx8LqEwhFfVVrAbRLOKfv6jOWmOvyjYHFWUC4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AC03C243AC
	for <alsa-devel@alsa-project.org>; Tue, 30 Nov 2010 07:56:05 +0100 (CET)
Received: by iwn7 with SMTP id 7so923231iwn.38
	for <alsa-devel@alsa-project.org>; Mon, 29 Nov 2010 22:56:05 -0800 (PST)
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

Greetings,

There is only a single mic on this netbook. However, the alsa device
shows up as stereo, and the right channel carries an inverted copy of
the left channel.

So when the two channels are summed to make a mono (e.g. for
telephony, or playback on mono internal speaker) it appears that there
is no signal.

Is there a way to "cure" this problem in the driver?  I can think of
* Force internal mic capture to be mono (left only)
* Copy left to right capture
* Invert right capture
but don't know how easy any are to implement.

Note more info about this 'card' can be found attached to
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/639846

thanks and regards

Eliot
