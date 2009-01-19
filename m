From: "S. Aguinaga" <sa_jr@yahoo.com>
Subject: {Q}simple selection of analog ports other than the
	headphones
Date: Mon, 19 Jan 2009 09:55:52 -0800 (PST)
Message-ID: <755002.27626.qm@web65616.mail.ac4.yahoo.com>
References: <mailman.1424.1231103612.1965.alsa-devel@alsa-project.org>
Reply-To: "S. Aguinaga" <sa_jr@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web65616.mail.ac4.yahoo.com (web65616.mail.ac4.yahoo.com
	[76.13.9.84]) by alsa0.perex.cz (Postfix) with SMTP id 105A9103802
	for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2009 18:55:53 +0100 (CET)
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


Dear Colleagues,

I have installed a fresh Fedora 9, and I have an Echo Layla3G (pci) card.  All I had to do was install the firmware, and it to playback out of Layla headphones.  This device has other Outputs, how I can I easily select the other channels for playback? 

aplay -l show these (along withthe Intel HDA for the built-in audio device):
card 1: Layla3G [Layla3G], device 0: Analog PCM [Layla3G]
  Subdevices: 8/8
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
  Subdevice #2: subdevice #2
  Subdevice #3: subdevice #3
  Subdevice #4: subdevice #4
  Subdevice #5: subdevice #5
  Subdevice #6: subdevice #6
  Subdevice #7: subdevice #7

so is it possible to type: aplay -D hw:1,0  thewavefile.wav and specify the subdevice?
Or do I need to specify in my .asoundrc file an alias?  with -D hw:1,0 I get sound out of Layla's headphone port only.

If you have links to useful howtos or documentation, please let me know.

// Sal Aguinaga
// Northwestern University
