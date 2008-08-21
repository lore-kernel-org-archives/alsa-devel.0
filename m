From: Simon Tremblay <bidou@videotron.qc.ca>
Subject: About ipc_key, ipc_gid and ipc_perm
Date: Thu, 21 Aug 2008 16:53:20 -0400
Message-ID: <48ADD5C0.8030307@videotron.qc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relais.videotron.ca (relais.videotron.ca [24.201.245.36])
	by alsa0.perex.cz (Postfix) with ESMTP id 1F25C103871
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Aug 2008 22:53:24 +0200 (CEST)
Received: from BiDoUMaC.local ([66.130.51.24]) by VL-MO-MR004.ip.videotron.ca
	(Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007;
	32bit))
	with ESMTP id <0K5Y00GFDY0Y9NE0@VL-MO-MR004.ip.videotron.ca> for
	alsa-devel@alsa-project.org; Thu, 21 Aug 2008 16:53:23 -0400 (EDT)
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

someone knows to what is related ipc_key, ipc_gid and ipc_perm settings
in /usr/share/alsa/alsa.conf file?

I ask that because even if I don't have an audio group created on my
embedded system, I can play a wave file with aplay.

But since I want to use -D plug:dmix option, I can't. It asks me to
create audio group.

But after that, I have a strange error I can't explain: audio open
error: Operation not permitted.

I think ipc_perm has something related to chmod 0660 file?

But what is ipc_key ? Does I have to set it somewhere since I installed
manually alsa on my system ?


Also, On SuSE, I see a + at the end of permission listing of each device
 file. What does it mean? Like this:

crw-rw----+ 1 dax audio 116, 7 2008-08-13 14:06 controlC0
crw-rw----+ 1 dax audio 116, 3 2008-08-13 14:06 midiC0D0
crw-rw----+ 1 dax audio 116, 6 2008-08-13 14:06 pcmC0D0c
crw-rw----+ 1 dax audio 116, 5 2008-08-13 14:06 pcmC0D0p
crw-rw----+ 1 dax audio 116, 4 2008-08-13 14:06 pcmC0D1p

I don't have that on my embedded system, is it something related only to
SuSE ?


Thanks,


Simon
