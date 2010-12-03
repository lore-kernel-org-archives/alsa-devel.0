From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Help wanted: emachines em350 internal mic
Date: Fri, 3 Dec 2010 10:33:26 +0800
Message-ID: <AANLkTi=T_5nGv85YE8DcDvyF_HFouh7a-6tOmk58+8EO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A96B0103AE0
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2010 03:33:30 +0100 (CET)
Received: by eyg24 with SMTP id 24so4768278eyg.38
	for <alsa-devel@alsa-project.org>; Thu, 02 Dec 2010 18:33:30 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> Greetings,


>> There is only a single mic on this netbook. However, the alsa device
>> shows up as stereo, and the right channel carries an inverted copy of
>> the left channel.

http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=59c774ed5ee00e9623a204c3234191d6a6d8cf7a


>> So when the two channels are summed to make a mono (e.g. for
>> telephony, or playback on mono internal speaker) it appears that there
>> is no signal.

>> Is there a way to "cure" this problem in the driver?  I can think of
>> * Force internal mic capture to be mono (left only)
>> * Copy left to right capture
>> * Invert right capture
>> but don't know how easy any are to implement.
