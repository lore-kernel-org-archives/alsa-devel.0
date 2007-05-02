From: Tim Harvey <tim_harvey@yahoo.com>
Subject: driver mixer control questions
Date: Tue, 1 May 2007 21:40:25 -0700 (PDT)
Message-ID: <28050.16506.qm@web35607.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web35607.mail.mud.yahoo.com (web35607.mail.mud.yahoo.com
	[66.163.179.146]) by alsa0.perex.cz (Postfix) with SMTP id C87D22438D
	for <alsa-devel@alsa-project.org>;
	Wed,  2 May 2007 06:40:26 +0200 (CEST)
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

I'm troubleshooting an issue with an ALSA driver I wrote for a very unique
hardware platform.  In this case I have an audio codec which only has a usable
'line-in' capture source.  Currently the only mixer control I've created is a
'Master Playback Volume'.  Do I need to create some kind of control for
'line-in'?  

I'm unclear how to 'register' capture inputs so that they will be returned by
the OSS mixer emulation's ioctl SOUND_MIXER_READ_RECMASK.  Currently that ioctl
returns 0 for my mixer device.

Also, is a control 'switch' such as 'Master Playback Switch' simply a mute
control or is it intended to be any type of control which could have enumerated
values?

Thanks,

Tim
