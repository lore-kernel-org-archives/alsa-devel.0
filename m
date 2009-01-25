From: Bankim Bhavsar <bankim.bhavsar@gmail.com>
Subject: Enumerating PCM devices
Date: Sat, 24 Jan 2009 19:48:03 -0800
Message-ID: <4eccebac0901241948r2df4ebbdve17e6d0cf7e1cc11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 13DC31037EA
	for <alsa-devel@alsa-project.org>; Sun, 25 Jan 2009 04:48:04 +0100 (CET)
Received: by fg-out-1718.google.com with SMTP id 16so3111388fgg.44
	for <alsa-devel@alsa-project.org>; Sat, 24 Jan 2009 19:48:03 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, alsa-user@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Alsa developers/users,

I'm using snd_device_name_hint("pcm"..) and then
snd_device_name_get_hint(.."NAME") to get the NAME parameter of pcm
devices.
>From what I understand each sound card can have multiple PCM devices.

Is it true that all sound cards that support Alsa will *always* have
"default" pcm device? I'm more inclined towards using
"default:CARD=<vendor>" as the
parameter to snd_pcm_open(). This way if the program configures
hardware params for any number of channels then the appropriate PCM
device will be selected on the sound card, correct?

Thanks,
Bankim.
