From: Viral Mehta <Viral.Mehta@lntinfotech.com>
Subject: redirecting audio to another desktop machine
Date: Mon, 21 Jun 2010 14:57:00 +0530
Message-ID: <70376CA23424B34D86F1C7DE6B9973430254343B3E@VSHINMSMBX01.vshodc.lntinfotech.com>
References: <70376CA23424B34D86F1C7DE6B9973430254343B29@VSHINMSMBX01.vshodc.lntinfotech.com>,
	<70376CA23424B34D86F1C7DE6B9973430254343B2B@VSHINMSMBX01.vshodc.lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail192.messagelabs.com (mail192.messagelabs.com
	[216.82.241.243])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FFCF24527
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jun 2010 11:27:20 +0200 (CEST)
In-Reply-To: <70376CA23424B34D86F1C7DE6B9973430254343B2B@VSHINMSMBX01.vshodc.lntinfotech.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi list,

I have an embedded device running linux kernel and a minimal filesystem.

I want to access this device remotely which means I should be able to connect to the device just like we do Remote Desktop over ethernet.
I am able to do this. I am able to send key-event and framebuffer data whenever my desktop machine connects to the device.

But, I am not able to send audio data on remote side.
I am really not sure which device file (/dev/snd/ ???) I should read and capture the data and should send across....
Or can I read the playback device ? I think NO.
Do I need to create some kind of virtual sound device ?

Any pointers/suggestions are appreciated.

Thanks,
Viral

This Email may contain confidential or privileged information for the intended recipient (s) If you are not the intended recipient, please do not use or disseminate the information, notify the sender and delete it from your system.

______________________________________________________________________
